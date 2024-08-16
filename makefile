help:
	@echo "Usage: make [target]"
	@echo "Targets:"
	@echo "\thelp: Show this help message"
	@echo "\tdev: Run the development services"
	@echo "\tprod: Run the production services"
	@echo "\tstop: Stop the services"
	@echo "\tlogs: Show the logs"

logs:
	@docker compose logs -f

dev:
	docker compose up --build -d --remove-orphans
	$(MAKE) -s logs

prod:
	@docker compose -f docker-compose.yml up --build -d --remove-orphans --force-recreate
	$(MAKE) -s logs

stop:
	# Stop the services
	@docker compose down

setup.env:
	@find . -type f -name '.env.example' -exec sh -c 'cp "$$0" "$${0%.example}"' {} \;

.DEFAULT_GOAL := help
.PHONY: help dev prod stop logs setup.env