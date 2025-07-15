COMPOSE_FILE = srcs/docker-compose.yml

all: build create-volumes generate-secrets up

up:
	@docker compose -f $(COMPOSE_FILE) up -d

down:
	@docker compose -f $(COMPOSE_FILE) down

build:
	@docker compose -f $(COMPOSE_FILE) build

generate-secrets:
	@chmod +x generate_secrets.sh
	@./generate_secrets.sh

create-volumes:
	@mkdir -p /home/amsaleh/data/wordpress \
		/home/amsaleh/data/adminer \
		/home/amsaleh/data/mariadb \
		/home/amsaleh/data/redis \
		/home/amsaleh/data/jupyterlab

clean-volumes:
	@rm -rf /home/amsaleh/data/wordpress \
		/home/amsaleh/data/adminer \
		/home/amsaleh/data/mariadb \
		/home/amsaleh/data/redis \
		/home/amsaleh/data/jupyterlab
	@docker volume prune -a

clean-images:
	@docker rmi -f nginx wordpress \
		mariadb proftpd adminer redis jupyterlab

clean-cache:
	@docker system prune -f

clean: clean-volumes clean-images clean-cache

light-clean: clean-volumes clean-images

re: clean build create-volumes

light-re: light-clean build create-volumes

.PHONY = all up down build generate-secrets \
	create-volumes clean-volumes clean-images \
	clean-cache clean light-clean re light-re