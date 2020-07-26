# Murmur docker image

This repository contains the Dockerfile to build a docker image containing the latest version of murmur, the server for [murmur](https://github.com/mumble-voip/mumble).

Key characterstics of this docker image compared to others:

- Built on alpine, so the image is smaller than the official one (~46MB vs +200MB).
- The configuration of the server is completely externalised to environment variables, i.e. all the content of the `mumble.ini` file can be replaced on startup.
- It adds support for Postgres as a database

The repository also contains a [docker-compose.yml](docker-compose.yml) file which starts the container with a postgres instance. The postgres instance
is defined with an external named volume to allow for persistent storage of the server configuration.
