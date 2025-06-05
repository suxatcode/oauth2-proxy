# oauth2-proxy: local-environment

Run `make up` to deploy local dex, etcd and oauth2-proxy instances in Docker containers. Review the [`Makefile`](Makefile) for additional deployment options.

## Reproducing issue #3057

The script `reproduce-3057.sh` runs a local Keycloak environment with Redis session storage. Use this to observe how sessions are not cleared when a refresh fails.

```bash
# Start the environment
./reproduce-3057.sh up

# When finished
./reproduce-3057.sh down
```

After starting, login at `http://oauth2-proxy.localtest.me:4180`. Then delete the session for that user in the Keycloak admin console (`http://keycloak.localtest.me:9080`). Wait about 30 seconds (the configured `cookie_refresh`), refresh the protected page and note that the session remains active.
