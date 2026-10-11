---
id: pbs-client
title: pbs-client — image Docker de proxmox-backup-client
sidebar_label: pbs-client
---

# pbs-client

Image [`mathmath350/pbs-client`](https://hub.docker.com/r/mathmath350/pbs-client) : `proxmox-backup-client`
dans un conteneur, pour les hôtes où il n'est pas installable (Unraid). Debian trixie + dépôt Proxmox
`pbs-no-subscription`, **amd64 uniquement**. Tags `latest` et version du client.

## Utilisation

- **Homelab Manager** : l'agent d'un hôte sans client mais avec Docker (capacité `backup:docker`) lance
  ses sauvegardes de répertoires avec cette image (réglable dans Paramètres › Sauvegardes).
- **backup_pbs_scripts** : mode `PBS_CLIENT_MODE="docker"`.

Le secret passe par l'environnement (`-e PBS_PASSWORD`), jamais par la ligne de commande ; les répertoires
sont montés en lecture seule au même chemin.

## Build et publication

| Commande | Effet |
|---|---|
| `make build` | construit `:latest` (sans cache : dernier client du dépôt Proxmox) |
| `make test` | vérifie le client dans l'image |
| `make release` | build + push de `:latest` et `:<version du client>` |

Sur un hôte Debian, `install_pbs_client_apt.sh` installe le client sans Docker.
