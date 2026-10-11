# pbs-client

Image Docker de `proxmox-backup-client`, pour sauvegarder vers un Proxmox Backup Server depuis un hôte
où le client n'est pas installable (Unraid, distribution non Debian) : [`mathmath350/pbs-client`](https://hub.docker.com/r/mathmath350/pbs-client).

- Debian trixie + dépôt Proxmox `pbs-no-subscription` ; **amd64 uniquement** (le dépôt Proxmox ne publie
  pas le client pour d'autres architectures).
- Point d'entrée : `proxmox-backup-client`. Tags : `latest` et la version du client (ex. `4.0.18`).

```bash
docker run --rm --network host \
  -e PBS_REPOSITORY -e PBS_PASSWORD -e PBS_FINGERPRINT \
  -v /mnt/user/appdata:/mnt/user/appdata:ro \
  mathmath350/pbs-client:latest backup appdata.pxar:/mnt/user/appdata --backup-id unraid
```

Utilisée par l'agent de [Homelab Manager](https://github.com/Mamath2000/homelab-manager) (sauvegardes de
répertoires, mode conteneur) et par [backup_pbs_scripts](https://github.com/Mamath2000/backup_pbs_scripts).

## Build et publication

```bash
make build     # construit mathmath350/pbs-client:latest
make test      # vérifie le client dans l'image
make release   # build + push de :latest et :<version du client>
```

`install_pbs_client_apt.sh` installe le client directement sur un hôte Debian (dépôt Proxmox), sans Docker.
