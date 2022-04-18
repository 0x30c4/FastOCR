build:
	docker build --force-rm $(op) -t fast_ocr:latest .
	docker build --force-rm $(op) -t ocr_nginx:latest proxy

# Delete the old image (if there any) and rebuild the image
up:
	# -docker image rm fast_ocr ocr_nginx
	# docker build --force-rm -t fast_ocr:latest .
	docker build --force-rm -t ocr_nginx:latest proxy
	./scripts/chmod-666-to-log-files.sh
	docker-compose --env-file ./env/.env.prod up $(op) 

up-dev:
	./scripts/chmod-666-to-log-files.sh
	docker-compose --env-file -f docker-compose.dev.yml ./env/.env.prod up $(op) 

down:
	docker-compose --env-file ./env/.env.prod down $(op)

down-dev:
	docker-compose --env-file -f docker-compose.dev.yml ./env/.env.prod down $(op)

# just run the api service
up-api:
	docker-compose --env-file ./env/.env.prod up db -d
	docker-compose --env-file ./env/.env.prod up ocr_api_srv

# stop the api service.
down-api:
	docker-compose --env-file ./env/.env.prod down db
	docker-compose --env-file ./env/.env.prod down ocr_api_srv

# For debugging the api
exec-api:
	bash -c 'docker exec -it $(docker ps | grep fast_ocr | cut -d " " -f 1) sh'
