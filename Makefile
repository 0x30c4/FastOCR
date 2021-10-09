build-dev:
	cp ./app/templates/index.html ./data/media/static/index.html
	docker build --force-rm $(op) -t fast_ocr:latest .

dev-up:
	docker-compose -f docker-compose-dev.yml --env-file ./config/.env.dev up  $(op) --remove-orphans

dev-down:
	docker-compose -f docker-compose-dev.yml --env-file ./config/.env.dev down --remove-orphans $(op)
