## Fast OCR is a free and opensource Optical Character Recognition Service.

## What The the service does?

This application receive a http multipart request with a image file, extract text using OCR from Tesseract and returns the result.
I know it's not an UNIQUE project but my main goal is to make a fast and less resource intensive OCR web service.

# Live Demo.
[https://ocr.0x30c4.dev](https://ocr.0x30c4.dev)

## Built With.

* [Docker](https://www.docker.com) - Platform and Software Deployment
* [FastApi](https://fastapi.tiangolo.com/) - Backend Frame-work.
* [Nginx](https://nginx.com/) - For Load Balancing.
* [ReactJs](https://reactjs.org/) - Front-end Frame-work 

## Prerequisites.

Make sure you have [git](https://git-scm.com/book/en/v2/Getting-Started-Installing-Git), [nodejs](https://nodejs.org/en/download/), [make](https://tldp.org/HOWTO/Software-Building-HOWTO-3.html) and [Docker](https://www.docker.com/products/docker-desktop) installed.

# Version.
* [Production](https://github.com/0x30c4/FastOCR#deploy-docker-container-production-version)

## Deploy Docker Container (Production Version.).
### Clone the repo.
```
$ git clone https://github.com/0x30c4/FastOCR
```

### Create the ```data/media/uploads``` directory where all the images will be.
```
$ mkdir -p data/media/uploads 
```

### You can change the ```uploads``` directory location by changing it from the ```.env.prod```

### Build the front-end with node.
```
$ cd front-end
$ npm run build
$ cd -
```

### Create a docker volume for the postgres database to be persistent.
```
$ docker volume create pgdata
```

If you want to take backup of the databse then you can backup the ```/var/lib/docker/volumes/pgdata``` directory.

### Build the container.
```
$ make build
```

### Now deploy the production version of the image using make.
```
$ make up # to run in the foreground.
or 
$ make up op=-d # to run the container in background.
```

### Check logs.
```
$ docker logs nginx_proxy # this is the nginx container.
$ docker logs ocr_api_srv # this is the FastApi app.
$ docker logs postgres # this is the postgres database.
```
You can add ```docker logs -f/--follow <container_name>``` to follow log output

### Stop the container.
```
$ make down
```
