# SPDX-FileCopyrightText: 2021 Kaelan Thijs Fouwels <kaelan.thijs@fouwels.com>
#
# SPDX-License-Identifier: MIT

COMPOSE=docker compose
STACK= -f activemq.yml -f alfresco.yml -f gateway.yml -f postgres.yml -f share.yml -f solr6.yml -f transforms.yml -f git.yml -f git-postgres.yml

.PHONY: pull, up, up-d, down, logs, certbot-request, certbot-renew, certbot-nginx

# Docker
pull:
	$(COMPOSE) $(STACK) pull
up: 
	$(COMPOSE) $(STACK) up
up-d: 
	$(COMPOSE) $(STACK) up -d
down:
	$(COMPOSE) $(STACK) down
logs:
	$(COMPOSE) $(STACK) logs -f

# Utility - Testing
certbot-request:
	docker exec -it certbot certbot certonly --keep-until-expiring --webroot --webroot-path /var/www/certbot --agree-tos --non-interactive --cert-name master \
		-d cms.fouwels.com -d git.fouwels.com \
		--rsa-key-size 3072 \
		--email kaelan.thijs@fouwels.com \
		-v \
		--post-hook "cp -L -r /etc/letsencrypt/live/master/. /keys && chmod -R 666 /keys/*"

certbot-renew:
	docker exec -it certbot certbot renew

certbot-nginx:
	docker container restart nginx
