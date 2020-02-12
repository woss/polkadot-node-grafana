---
title: "Run full node with grafana and docker"
---

## Step 1: Prepare the environment

If you're on
macOS, the easiest way to do that is to follow [installation guide here](https://docs.docker.com/docker-for-mac/install/)

If you are on Windows the easiest way to do that is to follow [installation guide here](https://docs.docker.com/docker-for-windows/install/)

Now let's clone the repository which contains the files we will need.

Open terminal of your choice in type:

```bash
git clone https://github.com/woss/polkadot-node-grafana

cd polkadot-node-grafana
```

## Set 2. Configuration

Most certainly you would like to change the name of the full node.

Default node name is `DragonsBreath` and it can be found in `.env` file in the root of this repository.

Default network will be `kusama` and it can be changed as well in `.env` file in the root of this repository.

Reuse the same terminal from Step 1. and type:

```bash
docker-compose config
```

If you didn't change any env variables in `.env` file then the output should be like this:

```yaml
networks:
  polkadot-node-net:
    driver: bridge
services:
  grafana:
    build:
      context: C:\Users\daniel\Projects\github\woss\polkadot-full-node-with-grafana
      dockerfile: Dockerfile
    environment:
      GF_SECURITY_ADMIN_PASSWORD: admin
      GF_SECURITY_ADMIN_USER: admin
      GF_USERS_ALLOW_SIGN_UP: "false"
    expose:
      - 3000
    labels:
      org.label-schema.group: polkadot
    links:
      - kusama
    networks:
      polkadot-node-net: null
    ports:
      - 33145:3000/tcp
    restart: unless-stopped
    volumes:
      - grafana_data:/var/lib/grafana:rw
      - C:\Users\daniel\Projects\github\woss\polkadot-full-node-with-grafana\grafana\provisioning:/etc/grafana/provisioning:rw
  kusama:
    command: polkadot --chain kusama --name "DragonsBreath" --grafana-external --wasm-execution Compiled
    image: chevdor/polkadot:latest
    networks:
      polkadot-node-net: null
    ports:
      - 9933/tcp
      - 30333/tcp
      - 9944/tcp
      - 9955/tcp
    restart: unless-stopped
    volumes:
      - kusama:/polkadot/.local/share/polkadot:rw
version: "3.0"
volumes:
  grafana_data: {}
  kusama: {}
```

To verify that everything will run as expected look for the changes you have made. If you see `DragonsBreath` and you have changed the `.env` file then your changes are not saved or you have made an typo.

## Step 3. Run your containers

Now when we have the config ready and valid let's run the 2 docker containers. One will be full node and another grafana for visualisation.

**NOTE**
Make sure you have allocated enough disk space in Desktop Docker config.

```bash
docker-compose up --detach
```

This will build new grafana image with installed [JSON datasource plugin](https://grafana.com/grafana/plugins/simpod-json-datasource)
Then it will run the grafana and polkadot containers.

## Step 4. Visualisation

If everything went OK you should be able to access the instance on following link [http://localhost:33145](http://localhost:33145)

Grafana comes with predefined dashboard called `Polkadot`.

```
Username: admin

Password: admin
```

Congratulations and enjoy your metrics! 😎
