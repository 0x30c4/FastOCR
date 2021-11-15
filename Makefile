build:
	docker build --force-rm $(op) -t fast_ocr:latest .
	docker build --force-rm $(op) -t ocr_nginx:latest proxy

up:
	docker-compose --env-file ./config/.env.prod up --remove-orphans $(op) 

down:
	docker-compose --env-file ./config/.env.prod down --remove-orphans $(op)

up-api:
	docker-compose --env-file ./config/.env.prod up -d db
	docker-compose --env-file ./config/.env.prod up -d ocr_api_srv

down-api:
	docker-compose --env-file ./config/.env.prod down db
	docker-compose --env-file ./config/.env.prod down ocr_api_srv
