build:
	docker build --force-rm $(op) -t fast_ocr:latest .
	docker build --force-rm $(op) -t ocr_nginx:latest proxy

up:
	docker-compose --env-file ./config/.env.prod up --remove-orphans $(op) 

down:
	docker-compose --env-file ./config/.env.prod down --remove-orphans $(op)

up-api:
	docker-compose --env-file ./config/.env.prod up db -d 
	docker-compose --env-file ./config/.env.prod up ocr_api_srv -d

down-api:
	docker-compose --env-file ./config/.env.prod down db
	docker-compose --env-file ./config/.env.prod down ocr_api_srv
