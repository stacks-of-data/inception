COMPOSE_FILE = srcs/docker-compose.yml

all: build create-volumes up

up:
	@docker compose -f $(COMPOSE_FILE) up -d

down:
	@docker compose -f $(COMPOSE_FILE) down

build:
	@docker compose -f $(COMPOSE_FILE) build

create-volumes:
	@mkdir -p /home/amsaleh/data/wordpress \
		/home/amsaleh/data/adminer \
		/home/amsaleh/data/mariadb /home/amsaleh/data/jupyterlab

clean-volumes:
	@rm -rf /home/amsaleh/data/wordpress \
		/home/amsaleh/data/adminer \
		/home/amsaleh/data/mariadb /home/amsaleh/data/jupyterlab
	@docker volume prune -a

clean-images:
	@docker rmi -f nginx wordpress mariadb proftpd adminer redis jupyterlab

clean-cache:
	@docker system prune -f

clean: clean-volumes clean-images clean-cache

clean-keep-cache: clean-volumes clean-images

.PHONY = all up down build create-volumes clean-volumes clean-images clean-cache clean clean-keep-cache