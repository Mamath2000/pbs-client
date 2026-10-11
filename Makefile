# Image Docker de proxmox-backup-client (Debian trixie + dépôt Proxmox pbs-no-subscription).
# Le dépôt Proxmox ne publie le client que pour amd64 : l'image est amd64 uniquement.
IMAGE    ?= mathmath350/pbs-client
PLATFORM ?= linux/amd64

.DEFAULT_GOAL := help
.PHONY: help build version test release

help: ## Affiche cette aide
	@grep -E '^[a-z-]+:.*## ' $(MAKEFILE_LIST) | awk -F':.*## ' '{printf "  \033[36m%-10s\033[0m %s\n", $$1, $$2}'

build: ## Construit $(IMAGE):latest (sans cache Docker : toujours le dernier client du dépôt Proxmox)
	docker build --pull --no-cache --platform $(PLATFORM) -t $(IMAGE):latest .

version: ## Version du client contenu dans $(IMAGE):latest
	@docker run --rm --platform $(PLATFORM) $(IMAGE):latest version 2>&1 | sed -n 's/^client version: *//p'

test: ## Vérifie que le client démarre dans l'image
	@v=$$($(MAKE) -s version); [ -n "$$v" ] || { echo "client introuvable dans l'image"; exit 1; }; echo "proxmox-backup-client $$v"

release: build test ## Build puis push de $(IMAGE):latest et $(IMAGE):<version du client>
	@v=$$($(MAKE) -s version); \
	docker tag $(IMAGE):latest $(IMAGE):$$v && \
	docker push $(IMAGE):$$v && docker push $(IMAGE):latest && \
	echo "publié : $(IMAGE):latest et $(IMAGE):$$v"
