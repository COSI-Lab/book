# Services

There are some services on Mirror whose documentation does not fit well in the documentation of the software project. These are mostly configuration and documentation about services running on Mirror. 

## NGINX

_updated: Jan 15th 2023_ 

[NGINX](https://nginx.org/en/) is Mirror's web server listening on ports 80 (http) and 443 (https). NGINX is responsible for serving project files, generating index pages (for example <https://mirror.clarkson.edu/blender>), and redirecting requests for the website to [Mirror Software](./software.md).

**Configuration:**


```
# /etc/nginx/nginx.conf

user www-data;
worker_processes auto;
pid /run/nginx.pid;
error_log /var/log/nginx/error.log;
include /etc/nginx/modules-enabled/*.conf;

events {
	worker_connections 1024;
	# multi_accept on;
}

http {

	##
	# Basic Settings
	##

	sendfile on;
	tcp_nopush on;
	types_hash_max_size 2048;
	keepalive_timeout 65;
	# server_tokens off;

	# server_names_hash_bucket_size 64;
	# server_name_in_redirect off;

	include /etc/nginx/mime.types;
	default_type application/octet-stream;

	##
	# SSL Settings
	##

	ssl_protocols TLSv1 TLSv1.1 TLSv1.2 TLSv1.3; # Dropping SSLv3, ref: POODLE
	ssl_prefer_server_ciphers on;

	##
	# Logging Settings
	##

	access_log /var/log/nginx/access.log;

	##
	# Gzip Settings
	##

	gzip on;

	# gzip_vary on;
	# gzip_proxied any;
	# gzip_comp_level 6;
	# gzip_buffers 16 8k;
	# gzip_http_version 1.1;
	# gzip_types text/plain text/css application/json application/javascript text/xml application/xml application/xml+rss text/javascript;
	
	proxy_cache_path /var/cache/nginx-cache keys_zone=cache:10m;

	##
	# Virtual Host Configs
	##

	include /etc/nginx/conf.d/*.conf;
	include /etc/nginx/sites-enabled/*;
}
```

```
# /etc/nginx/conf.d/default.conf

# Allow support for websockets
map $http_upgrade $connection_upgrade {
	default Upgrade;
	''      close;
}

map $request_uri $redirect_uri {
	/index.html /home;
	/distributions.html /projects;
	/distributions /projects;
	/software.html /projects;
	/software /projects;
	/stats.html /stats;
	/history.html /history;
}

map $status $ban {
	444	1;
	default 0;
}

# access log format
log_format new '"$time_local" "$remote_addr" "$request" "$status" "$body_bytes_sent" "$request_length" "$http_user_agent"';

server {
        server_name mirror.clarkson.edu;

	# logging
	access_log /var/log/nginx/access.log new;

	# Migration from old mirror
	if ( $redirect_uri ) {
		return 301 $redirect_uri;
	}

  location = /wikimedia {
          return 301 https://wikimedia.mirror.clarkson.edu;
  }

	location = / {
		return 301 /home;
	}


	# Static file hosting
	location / {
		root /var/www;
		autoindex on;
		# First attempt to serve request as file, then
		# as directory, then fall back to displaying a 404.
		try_files $uri $uri/ =404;

		# Cache
		proxy_cache cache;
	}

	# Handle the websocket for the map
	location /ws {
		#proxy_pass http://localhost:8012;
		proxy_pass http://localhost:30302;
		proxy_http_version 1.1;
		proxy_set_header Upgrade $http_upgrade;
		proxy_set_header Connection $connection_upgrade;
		proxy_set_header Host $host;
	}

	# Set of locations that should be proxied to the web server
	location ~ ^/(home|history|stats|projects|sync|map|about|static) {
		#proxy_pass http://127.0.0.1:8012$request_uri;
		proxy_pass http://127.0.0.1:30301$request_uri;
	}

	# Relocation of linuxmint things
	rewrite ^/linuxmint/iso/images/(.*)$ /linuxmint-images/$1 permanent;
	rewrite ^/linuxmint/packages/(.*)$ /linuxmint-packages/$1 permanent;

	# Allow localhost scrapping of status
	location = /status {
		allow 127.0.0.1;
		stub_status;
	}

	# Banned locations
	location = /centos/8.5.2111/isos/aarch64/CentOS-8.5.2111-aarch64-dvd1.iso {
		return 444;
	}

	location = /centos/8.5.2111/isos/x86_64/CentOS-8.5.2111-x86_64-dvd1.iso {
		return 444;
	}

	# Ban logging
	access_log /var/log/nginx/ban.log combined if=$ban;


	listen [::]:80 default_server;
	listen 80 default_server;
  listen [::]:443 ssl; # managed by Certbot
  listen 443 ssl; # managed by Certbot
  ssl_certificate /etc/letsencrypt/live/mirror.clarkson.edu/fullchain.pem; # managed by Certbot
  ssl_certificate_key /etc/letsencrypt/live/mirror.clarkson.edu/privkey.pem; # managed by Certbot
  include /etc/letsencrypt/options-ssl-nginx.conf; # managed by Certbot
  ssl_dhparam /etc/letsencrypt/ssl-dhparams.pem; # managed by Certbot

}

server {
	server_name wikimedia.mirror.clarkson.edu;
	root /storage/wikimedia;

	location /home {
		return 301 /;
	}

	location / {
		index index.html;
	}

	listen 80;
	listen [::]:80;
	listen [::]:443 ssl; # managed by Certbot
	listen 443 ssl; # managed by Certbot
	ssl_certificate /etc/letsencrypt/live/mirror.clarkson.edu/fullchain.pem; # managed by Certbot
	ssl_certificate_key /etc/letsencrypt/live/mirror.clarkson.edu/privkey.pem; # managed by Certbot
	include /etc/letsencrypt/options-ssl-nginx.conf; # managed by Certbot
	ssl_dhparam /etc/letsencrypt/ssl-dhparams.pem; # managed by Certbot
}
```


## RKHunter

_updated: Nov 6th 2022_

[RKHunter](https://rkhunter.sourceforge.net/) or "Rootkit Hunter" is a script that checks linux systems for signs of known linux rootkits. Assuming other security measures are well followed we don't expect Mirror to become infected with a rootkit. It might be worth running the tool automatically (maybe daily?), however, we don't currently have a satisfactory method of sending mail when warnings occur. Until then (and maybe forever) here are some instructions for manually running RKHunter. 


**Install:**

```
sudo apt install rkhunter
```

**Update:**

This command tells RKHunter to check for newly added software packages. We don't install software often, but it isn't a bad idea to run this event once in a while.

```
sudo rkhunter --propupd
```

**Usage:**

```
sudo rkhunter --check --skip-keypress --report-warnings-only
```

| Flag | Meaning |
| :--: | :--- |
| `--checkall` | Runs all tests. |
| `--skip-keypress` | RKHunter has a pretty annoying "press ENTER for the next scan". This disables that. |
| `--report-warnings-only` | Recommended when using `--skip-keypress` otherwise it's easy to miss results. |

**False positives:**

```
Warning: The command '/usr/bin/lwp-request' has been replaced by a script: /usr/bin/lwp-request: Perl script text executable
```

This seems to be a well known issue on Debian based machines. So far two attempts have been made to stop this error, both without success.

