
# Setup-Env

## This script allows you to dynamically manage your environment variables from one single json file.


```bash
$ ./setenv.py --help
usage: setenv.py [-h] [-t TARGET_KEY] FILE DIR ENV_JSON

Reads the environment variables and creates separate env files for all the
services defined in the docker-compose

positional arguments:
  FILE                  The target docker-compose file.
  DIR                   The directory where the processed env files will be
                        placed.
  ENV_JSON              The targeted key env file in json format.

optional arguments:
  -h, --help            show this help message and exit
  -t TARGET_KEY, --target-key TARGET_KEY
                        The targeted key which should be parsed.
```

# Example How To Use.

Here for example if you have a docker-compose.yml file that has some internal 
environment variables and some environment that needs to be pushed to the container,
then instead of putting all the variables manually or setting up environment variables
for development version and production version separately we can put it inside a json file and
let the script take over our manual work.


## Here is an example what it does.
```yml
...
  services:
    image: postgres
    environment:
      - POSTGER_USER=user
      - POSTGRES_PASSWORD=1234
      ...
    ports:
      - ${HOST_BIND_PORT}:${CONTAINER_BIND_PORT}
...
```

```bash


$ setenv.py docker-compose.yml env/ env/env-example.json -t production

[CREATED] ./env/.env.ocr_api_srv_prod for ocr_api_srv_prod.
[CREATED] ./env/.env.db_prod for db_prod.
[CREATED] ./env/.env.proxy_prod for proxy_prod.
[CREATED] env/.env.production for docker-compose.
```

