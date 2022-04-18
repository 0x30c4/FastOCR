
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

### This is a typical docker-compose file.
```yml
...
  services:
    db:
      image: postgres
      environment:
        - POSTGER_USER=user
        - POSTGRES_PASSWORD=1234
        ...
      ports:
        - ${HOST_BIND_PORT_DB}:${CONTAINER_BIND_PORT_DB}

    api:
      image: the_api
      environment:
        - APP_KEY="...."
        - CONTAINER_BIND_PORT_API=8888
        - DB_URL="url://"
        - DEBUG=0
      ports:
        - ${HOST_BIND_PORT_API}:${CONTAINER_BIND_PORT_API}
...
```

### The .env file will look something like this
```
HOST_BIND_PORT_API=8888
HOST_BIND_PORT_DB=1111
CONTAINER_BIND_PORT_API=9999
CONTAINER_BIND_PORT_DB=2222
```

As you can see here to control the ```environment``` we have to pass each variable manually.
Or we can just use ```env_file``` to setup a separate env file for each of the service. 
Although we can have a global environment variable file where env variables of services will be.
Though that will work but that's generally not a good practice.

So, the only option we are left with it to use separate env files for service's but managing them
is much more painful. So, to solve that what if we can just put all of our environment variables in a
single json file and let this script manage that for us.

Surely we can do this and this script is for that purpose only.

So, to solve this issue we can create a json file like this. 
We will call it ```example-env.json```

```json
{
  "production": {
    "db": {
        "POSTGRES_PASSWORD": "1234",
        "POSTGER_USER": "user"
        "HOST_BIND_PORT_DB": 1111,
        "CONTAINER_BIND_PORT_DB": 2222,
        "DEBUG": 0
      },
      "api": {
        "API_KEY": "....",
        "CONTAINER_BIND_PORT_API": 8888,
        "DB_URL": "url://"
      }
  }
  "development": {
    "db": {
        "POSTGRES_PASSWORD": "1234",
        "POSTGER_USER": "user"
        "HOST_BIND_PORT_DB": 1111,
        "CONTAINER_BIND_PORT_DB": 5555,
        "DEBUG": 1
      },
      "api": {
        "API_KEY": "....",
        "CONTAINER_BIND_PORT_API": 5555,
        "DB_URL": "url://"
      }
  }
}
```
And for the updated docker-compose file we will make just one simple change, 
we will replace the ```environment``` with ```env_file```. And the env file 
will be created by running the setenv.py 

```yml
...
  services:
    db:
      image: postgres
      env_file:
        - ./env/.env.db
      ports:
        - ${HOST_BIND_PORT_DB}:${CONTAINER_BIND_PORT_DB}

    api:
      image: the_api
      env_file:
        - ./env/.env.the_api
      ports:
        - ${HOST_BIND_PORT_API}:${CONTAINER_BIND_PORT_API}
...
```
And now if we run this command to create the env files
```bash

  Script Name                  The targeted directory where you want you keep the all the dynamically
  |                            |  generated .env file.
  |                            |                             _the targeted version
  |                            |                            | 
  V                            V                            V
$ setenv.py docker-compose.yml env/ env/example-env.json -t production
            ^                       ^
            |                       |_Our example env file here 
            |
            docker-compose file name

[CREATED] ./env/.env.ocr_api_srv_prod for ocr_api_srv_prod.
[CREATED] ./env/.env.db_prod for db_prod.
[CREATED] ./env/.env.proxy_prod for proxy_prod.
[CREATED] env/.env.production for docker-compose.
```
