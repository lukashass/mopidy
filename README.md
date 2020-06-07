# Mopidy Docker Image

![Docker Cloud Build Status](https://img.shields.io/docker/cloud/build/lukashass/mopidy)
![Docker Pulls](https://img.shields.io/docker/pulls/lukashass/mopidy)
![Docker Image Size (tag)](https://img.shields.io/docker/image-size/lukashass/mopidy/latest)

## Installed extensions

Have a look inside [Dockerfile](Dockerfile).

## Deployment example

```yml
version: '3'

services:
  mopidy:
    image: lukashass/mopidy:3
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
