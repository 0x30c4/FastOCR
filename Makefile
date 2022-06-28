build:
	docker build --force-rm $(op) -t fast_ocr:latest .
	docker build --force-rm $(op) -t ocr_nginx:latest proxy

# # Delete the old image (if there any) and rebuild the image
up:
	# -docker image rm fast_ocr ocr_nginx
	# docker build --force-rm -t fast_ocr:latest .
	docker build --force-rm -t ocr_nginx:latest proxy
	./scripts/chmod-666-to-log-files.sh
	docker-compose --env-file ./env/.env.production up $(op) 

down:
	docker-compose down $(op)


up-dev:
	./scripts/chmod-666-to-log-files.sh
	docker-compose -f docker-compose.dev.yml up $(op) 

down-dev:
	docker-compose -f docker-compose.dev.yml down $(op) 

# # just run the api service
up-api:
	docker-compose --env-file ./env/.env.production up -d db_prod 
	docker-compose --env-file ./env/.env.production up -d ocr_api_srv_prod

# # stop the api service.
down-api:
	docker-compose down db_prod
	docker-compose down ocr_api_srv_prod

# For debugging the api
exec-api:
	bash -c 'docker exec -it `docker ps | grep fast_ocr | cut -d " " -f 1` sh'
