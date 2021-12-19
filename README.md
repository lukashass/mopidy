# Mopidy Docker Image

[![Build Image](https://github.com/lukashass/snapcast/actions/workflows/build.yml/badge.svg)](https://github.com/lukashass/snapcast/actions/workflows/build.yml)

## Installed extensions

Have a look inside [Containerfile](Containerfile).

## Deployment example

```yml
version: '3'

services:
  mopidy:
    image: ghcr.io/lukashass/mopidy
    restart: always
    ports:
      - 6600:6600
      - 6680:6680
    volumes:
      - ./mopidyfifo:/tmp/snapfifo
      - ./music:/var/lib/mopidy/media:ro
      - ./playlists:/var/lib/mopidy/playlists
      - ./mopidy.conf:/var/lib/mopidy/.config/mopidy/mopidy.conf
      - ./mopidy/.cache:/var/lib/mopidy/.cache
      - ./mopidy/core:/var/lib/mopidy/core
      - ./mopidy/http:/var/lib/mopidy/http
      - ./mopidy/local:/var/lib/mopidy/local
```

For a more elaborate example including config files see <https://gitlab.com/lukashass/server/-/tree/master/musicplayer>
