# Services

There are some services on Mirror whose documentation does not fit well in the documentation of the software project. These are mostly configuration and documentation about services running on Mirror. 

## NGINX

_updated: Jan 15th 2023_ 

[NGINX](https://nginx.org/en/) is Mirror's web server listening on ports 80 (http) and 443 (https). NGINX is responisbile for servering project files, generating index pages (for example <https://mirror.clarkson.edu/blender>), and redirecting requests for the website to [Mirror Software](./software.md).

**Configuration:**


```
# /etc/nginx/nginx.conf

user  nginx;
worker_processes  auto;

error_log  /var/log/nginx/error.log notice;
pid        /var/run/nginx.pid;

events {
    worker_connections  1024;
}

http {
        sendfile on;
        tcp_nopush on;
        tcp_nodelay on;
        keepalive_timeout 65;

        include /etc/nginx/mime.types;
        default_type application/octet-stream;

        ##
        # SSL Settings
        ##

        ssl_protocols TLSv1 TLSv1.1 TLSv1.2 TLSv1.3;
        ssl_prefer_server_ciphers on;

        ##
        # Gzip Settings
        ##

        gzip on;

        ##
        # Cache
        ##
        proxy_cache_path /var/cache/nginx-cache keys_zone=cache:10m;

        include /etc/nginx/conf.d/*;
}
```

```
# /etc/nginx/conf.d/default.conf

# Allow support for websockets
map $http_upgrade $connection_upgrade {
	default Upgrade;
	''      close;
}

# Don't kill old links
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
# This is required for easy parsing by the Mirror project
log_format new '"$remote_addr" "$time_local" "$request" "$status" "$body_bytes_sent" "$request_length" "$http_user_agent"';

server {
        listen 80 default;
        listen [::]:80 default;
        server_name _;

	# logging
	access_log /var/log/nginx/access.log new;

	# Migration from old mirror
	if ( $redirect_uri ) {
		return 301 $redirect_uri;
	}
	location = / {
		return 301 /home;
	}

        # SSL configuration
        listen 443 ssl;
        listen [::]:443 ssl;
	ssl_certificate /etc/letsencrypt/live/mirror.clarkson.edu/fullchain.pem; # managed by Certbot
	ssl_certificate_key /etc/letsencrypt/live/mirror.clarkson.edu/privkey.pem; # managed by Certbot

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
		proxy_pass http://localhost:8012;
		proxy_http_version 1.1;
		proxy_set_header Upgrade $http_upgrade;
		proxy_set_header Connection $connection_upgrade;
		proxy_set_header Host $host;
	}

	# Set of locations that should be proxied to the web server
	location ~ ^/(home|history|stats|projects|sync|favicon.ico|map|health|css/|img/|js/|fonts/|api/) {
		proxy_pass http://127.0.0.1:8012$request_uri;
	}

	# Relocation of linuxmint things
	rewrite ^/linuxmint/iso/images/(.*)$ /linuxmint-images/$1 permanent;
	rewrite ^/linuxmint/packages/(.*)$ /linuxmint-packages/$1 permanent;

	# Allow localhost scrapping of status
	location = /status {
		allow 127.0.0.1;
		stub_status;
	}

	# There is this very strange behavior where IP's located in China are very interested in these two files 
	# This useless traffic accounts for around 15% of all requests to Mirror. Nothing we have tried has effectively stopped this traffic.
	# Returning 444 tell NGINX to ignore these connections as soon as possible (there is no point in sending a 404 page)
	location = /centos/8.5.2111/isos/aarch64/CentOS-8.5.2111-aarch64-dvd1.iso {
		return 444;
	}

	location = /centos/8.5.2111/isos/x86_64/CentOS-8.5.2111-x86_64-dvd1.iso {
		return 444;
	}

	# Track access to these odd locations in another file. Maybe we could IP-Ban these connections.
	access_log /var/log/nginx/ban.log combined if=$ban;
}
```

## Influxdb

_updated: Jan 15th 2023_ 

[Influxdb](https://www.influxdata.com/products/influxdb-overview/) is an open source [time-series database](https://en.wikipedia.org/wiki/Time_series_database). [Mirror Software](./software.md) will process our [NGINX](#nginx) log files extracting interesting information, aggrate it, and then store the results in Influxdb. 

Data in Influxdb is stored in buckets.

| Bucket name | description | 
|-------------|-------------|
| stats       | statistics generated from Mirror's software 
| system      | system statistics provided by [Telegraf](#telegraf)
| public      | down sampled statistics. More appropriate for public use 

Once data is stored in Influxdb we are free to set up additional logging and alerting or arbitrary tasks. We have two important tasks that further aggrates Mirror data from 1 minute intervals to 1 hour intervals. 

```
option task = {name: "Down Sample Clarkson Stats", every: 1h}

// Defines a data source
data =
    from(bucket: "stats")
        |> range(start: 0, stop: now())
        |> filter(fn: (r) => r["_measurement"] == "clarkson")
        |> drop(columns: ["_start", "_stop"])
time = now()

data
    |> last()
    |> map(fn: (r) => ({r with _time: time}))
    |> to(bucket: "public")

```

```
option task = {name: "Down Sample Nginx Stats", every: 1h}

// Defines a data source
data =
    from(bucket: "stats")
        |> range(start: 0, stop: now())
        |> filter(fn: (r) => r["_measurement"] == "nginx")
        |> drop(columns: ["_start", "_stop"])
time = now()

data
    |> last()
    |> map(fn: (r) => ({r with _time: time}))
    |> to(bucket: "public")
```

## Telegraf 

[Telegraf](https://www.influxdata.com/time-series-platform/telegraf/) is an open source agent that records system information and uploads it to any Influxdb server. This our configuration with the API key remove.

**Configuration:**

```
# Configuration for telegraf agent
[agent]
  ## Default data collection interval for all inputs
  interval = "10s"

  ## Rounds collection interval to 'interval'
  ## ie, if interval="10s" then always collect on :00, :10, :20, etc.
  round_interval = true

  ## Telegraf will send metrics to outputs in batches of at most
  ## metric_batch_size metrics.
  ## This controls the size of writes that Telegraf sends to output plugins.
  metric_batch_size = 1000

  ## Maximum number of unwritten metrics per output.  Increasing this value
  ## allows for longer periods of output downtime without dropping metrics at the
  ## cost of higher maximum memory usage.
  metric_buffer_limit = 10000

  ## Collection jitter is used to jitter the collection by a random amount.
  ## Each plugin will sleep for a random time within jitter before collecting.
  ## This can be used to avoid many plugins querying things like sysfs at the
  ## same time, which can have a measurable effect on the system.
  collection_jitter = "0s"

  ## Default flushing interval for all outputs. Maximum flush_interval will be
  ## flush_interval + flush_jitter
  flush_interval = "10s"
  ## Jitter the flush interval by a random amount. This is primarily to avoid
  ## large write spikes for users running a large number of telegraf instances.
  ## ie, a jitter of 5s and interval 10s means flushes will happen every 10-15s
  flush_jitter = "0s"

  ## By default or when set to "0s", precision will be set to the same
  ## timestamp order as the collection interval, with the maximum being 1s.
  ##   ie, when interval = "10s", precision will be "1s"
  ##       when interval = "250ms", precision will be "1ms"
  ## Precision will NOT be used for service inputs. It is up to each individual
  ## service input to set the timestamp at the appropriate precision.
  ## Valid time units are "ns", "us" (or "µs"), "ms", "s".
  precision = ""

  ## Override default hostname, if empty use os.Hostname()
  hostname = ""

  ## If set to true, do no set the "host" tag in the telegraf agent.
  omit_hostname = false
[[outputs.influxdb_v2]]
  ## The URLs of the InfluxDB cluster nodes.
  urls = ["https://localhost:8086"]

  ## Token for authentication.
  token = "REDACTED"

  ## Organization is the name of the organization you wish to write to; must exist.
  organization = "COSI"

  ## Destination bucket to write into.
  bucket = "system"

  ## Optional TLS Config for use on HTTP connections.
  # tls_ca = "/etc/telegraf/ca.pem"
  # tls_cert = "/etc/telegraf/cert.pem"
  # tls_key = "/etc/telegraf/key.pem"

  ## Use TLS but skip chain & host verification
  insecure_skip_verify = true
[[inputs.cpu]]
  ## Whether to report per-cpu stats or not
  percpu = true

  ## Whether to report total system cpu stats or not
  totalcpu = true

  ## If true, collect raw CPU time metrics
  collect_cpu_time = false

  ## If true, compute and report the sum of all non-idle CPU states
  report_active = false
[[inputs.disk]]
  ## Ignore mount points by filesystem type.
  ignore_fs = ["tmpfs", "devtmpfs", "devfs", "iso9660", "overlay", "aufs", "squashfs"]
[[inputs.diskio]]
[[inputs.mem]]
[[inputs.net]]
[[inputs.nginx]]
  # An array of Nginx stub_status URI to gather stats.
  urls = ["http://localhost/status"]

  # HTTP response timeout (default: 5s)
  response_timeout = "5s"
[[inputs.system]]
[[inputs.zfs]]
```

## RKHunter

_updated: Nov 6th 2022_

[RKHunter](https://rkhunter.sourceforge.net/) or "Rootkit Hunter" is a script that checks linux systems for signs of known linux rootkits. Assuming other security measures are well followed we should not expect Mirror to become infected with a rootkit. It might be worth an investment in running the tool automaticaaly (maybe daily?) but we don't currently have satisfactory methods of sending mail when warnings occur. Until then (and maybe forever) here is some instructions on manually running RKHunter. 


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

This seems to be a wellknown issue on debian based machines. 2 attempts have been made to stop this error without success.

