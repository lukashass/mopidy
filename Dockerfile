FROM debian:buster-slim

RUN apt-get update \
    && DEBIAN_FRONTEND=noninteractive apt-get install -y \
        curl \
        gnupg
RUN curl -L https://apt.mopidy.com/mopidy.gpg | apt-key add -
RUN curl -L https://apt.mopidy.com/mopidy.list -o /etc/apt/sources.list.d/mopidy.list
RUN apt-get update \
    && DEBIAN_FRONTEND=noninteractive apt-get install -y \
        mopidy \
        mopidy-local-sqlite \
        mopidy-soundcloud \
        mopidy-spotify \
        mopidy-tunein
RUN mkdir -p /var/lib/mopidy/.config
RUN ln -s /config /var/lib/mopidy/.config/mopidy

# Clean-up
RUN apt-get purge --auto-remove -y \
        curl
RUN apt-get clean
RUN rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* ~/.cache

# Default configuration.
COPY mopidy.conf /config/mopidy.conf

# Allows any user to run mopidy, but runs by default as a randomly generated UID/GID.
ENV HOME=/var/lib/mopidy
RUN set -ex \
    && usermod -G audio,sudo mopidy \
    && chown mopidy:audio -R $HOME \
    && chmod go+rw -R $HOME

# Runs as mopidy user by default.
USER mopidy

VOLUME ["/var/lib/mopidy/local", "/var/lib/mopidy/media", "/var/lib/mopidy/m3u"]

EXPOSE 6600 6680 5555/udp

CMD ["/usr/bin/mopidy"]
