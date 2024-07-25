# Creating a website

_updated: Jul 25th, 2024_

COSI websites are stored in Docker containers on [Tiamat](../infrastructure/servers/tiamat.md).

1. Get permission to host a site from the current Lab Directors.

2. Create a DNS entry for your website on [Zones](https://github.com/COSI-Lab/zones). 
    - Follow the directions in the readme for Zones
    - At step 3, add a line to both `db.cosi` and `db.cslabs` using the following format:
    ```dns
    <requested_subdomain>  IN CNAME    tiamat
    ```

3. Clone your repo on Tiamat in the `/docker` directory (at the root of the file system). Your repo must contain a `docker-compose.yaml` as well as anything else that you need for your container to function.

4. Update `/docker/caddy/Caddyfile` with the following information related to your site:
    ```caddyfile
    <requested_subdomain>.cslabs.clarkson.edu{
        reverse_proxy <container_name>:80
    }

    <requested_subdomain>.cosi.clarkson.edu{
        reverse_proxy <container_name>:80
    }
    ```
    **NOTE:** This is the bare minimum required to make your site available. You can read more about configuring your entry [here](https://caddyserver.com/docs/caddyfile).

5. Restart all the containers by running `./run.sh` in `/docker`.
