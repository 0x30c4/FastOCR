build-dev:
	docker build --force-rm $(op) -t fast_ocr:latest .
	docker build --force-rm $(op) -t ocr_nginx:latest proxy

prod-up:
	docker-compose --env-file ./config/.env.prod up --remove-orphans $(op) 

prod-down:
	docker-compose --env-file ./config/.env.prod down --remove-orphans $(op)
