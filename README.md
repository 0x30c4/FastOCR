## Fast OCR is a free and opensource Optical Character Recognition Service.

## What The the service does?

This application receive a http multipart request with a image file, extract text using OCR from Tesseract and returns the result.

# Live Demo.
[https://ocr.0x30c4.dev](https://ocr.0x30c4.dev)

## Built With.

* [Docker](https://www.docker.com) - Platform and Software Deployment
* [Flask](https://flask.palletsprojects.com/en/2.0.x/) - Backend Frame-work.
* [Nginx](https://nginx.com/) - For Load Balancing.
* [Bootstrap](https://getbootstrap.com/) For the frontend.
* [jQuery](https://jquery.com/) - JavaScript Library

## Prerequisites.

Make sure you have [git](https://git-scm.com/book/en/v2/Getting-Started-Installing-Git), [make](https://tldp.org/HOWTO/Software-Building-HOWTO-3.html) and [Docker](https://www.docker.com/products/docker-desktop) installed.

# Version.
* [Development](https://github.com/0x30c4/FastOCR#deploy-docker-container-development-version)<br>
* [Production](https://github.com/0x30c4/FastOCR#deploy-docker-container-production-version)

## Deploy Docker Container (Development Version.).
### Clone the repo.
```
$ git clone https://github.com/0x30c4/FastOCR
```

### Build the container.
```
$ make build-dev
```

### Now Run the development version of the image using make.
```
$ make dev-up # to run in the foreground.
or 
$ make dev-up op=-d # to run the container in background.
```

### Check logs.
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
