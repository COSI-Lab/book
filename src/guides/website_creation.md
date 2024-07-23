# Creating a website

_updated: Jul 23rd, 2024_

COSI websites are stored in docker containers on Tiamat.

1. Get permission

2. Create a DNS entry for your website on [zones](https://github.com/COSI-Lab/zones). 
    - Websites are hosted on [Tiamat](../infrastructure/servers/tiamat.md)
    - in both db.cosi and db.cslabs files create a new entry 
    ```
    <website name>  IN CNAME    tiamat
    ```
    - follow the directions in the zones' readme

3. Place your repo on tiamat in the `/docker` folder with a `docker-compose.yaml`, a `Dockerfile`, and a `nginx.conf` and anything else you need. 

4. Run the containers using `./run.sh`