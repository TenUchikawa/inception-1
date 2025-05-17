PROJECT = inception_inc
SRC = srcs
DC = docker compose -f $(SRC)/docker-compose.yml
ENVF = $(SRC)/.env.inc

DB_DIR = /home/kryochik/data/inc_db
SSL_DIR = /home/kryochik/data/inc_ssl
WP_DIR = /home/kryochik/data/inc_wp

all: mk_vols start

build: mk_vols
	@echo "Building inception_inc containers..."
	$(DC) build

start: build
	@echo "Launching inception_inc..."
	$(DC) up -d

down:
	@echo "Stopping inception_inc..."
	$(DC) down

clean: rm_vols
	@echo "Cleanup inception_inc..."
	$(DC) down -v --rmi all

re: clean all

logs:
	@echo "Logs inception_inc..."
	$(DC) logs -f

hc:
	@echo "Health inception_inc..."
	$(DC) ps

fclean: clean rm_vols
	@echo "Full prune inception_inc..."
	docker system prune -af

rm_vols:
	@echo "Remove inception_inc volumes..."
	@sudo rm -rf $(DB_DIR) $(SSL_DIR) $(WP_DIR)

mk_vols:
	@echo "Check inception_inc volumes..."
	@[ -d "$(DB_DIR)" ] || mkdir -p $(DB_DIR)
	@[ -d "$(SSL_DIR)" ] || mkdir -p $(SSL_DIR)
	@[ -d "$(WP_DIR)" ] || mkdir -p $(WP_DIR)

.PHONY: all build start down clean re logs hc fclean rm_vols mk_vols