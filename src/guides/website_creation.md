# Creating a website

_updated: Jul 23rd, 2024_

COSI websites are stored in docker containers on [Tiamat](../infrastructure/servers/tiamat.md).

1. Get permission

2. Create a DNS entry for your website on [zones](https://github.com/COSI-Lab/zones). 
    - in both db.cosi and db.cslabs files create a new entry 
    ```
    website_name  IN CNAME    tiamat
    ```
    - follow the directions in the readme for zones

3. Place your repo on Tiamat in the `/docker` folder with a `docker-compose.yaml`, a `Dockerfile`, and anything else you need. 

4. Update /docker/caddy/Caddyfile with your website information
    ```
    websitename.cslabs.clarkson.edu{
        reverse_proxy websitename:80
    }
    websitename.cosi.clarkson.edu{
        reverse_proxy websitename:80
    }
    # note: not all entries look like this and more information can be entered
    ```

5. Restart all the containers using `./run.sh`