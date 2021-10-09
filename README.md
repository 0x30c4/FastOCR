## Fast OCR is a free and opensource Optical Character Recognition Service.

## What The the service does

This application receive a http multipart request with a image file, extract text using OCR from Tesseract and returns the result.

## Prerequisites

Make sure you have [git](https://git-scm.com/book/en/v2/Getting-Started-Installing-Git), [make](https://tldp.org/HOWTO/Software-Building-HOWTO-3.html) and [Docker](https://www.docker.com/products/docker-desktop) installed.

# Version.
   [Development](https://github.com/0x30c4/FastOCR#deploy-docker-container-development-version)
   [Production](https://github.com/0x30c4/FastOCR#deploy-docker-container-production-version)

## Deploy Docker Container (Development Version.).
### Clone/git pull the repo into any local directory
```
$ git clone https://github.com/0x30c4/FastOCR
```

### Build the container.
```
$ make build-dev
```

### Now Run the development version of the image using make
```
$ make dev-up # to run in the foreground.
or 
$ make dev-up op=-d # to run the container in background.
```

### Check logs
```
$ docker logs nginx_proxy # this is the nginx container.
$ docker logs ocr_api_srv # this is the flask app.
```
You can add ```docker logs -f/--follow <container_name>``` to follow log output

### Stop the container.
```
$ make dev-down
```

## Deploy Docker Container (Production Version.).
### Under development.
