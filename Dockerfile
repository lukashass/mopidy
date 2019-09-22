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

# Clean-up
RUN apt-get purge --auto-remove -y \
        curl
RUN apt-get clean
RUN rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* ~/.cache

# Default configuration.
COPY mopidy.conf /config/mopidy.conf

VOLUME ["/data", "/config"]

EXPOSE 6600 6680

CMD ["/usr/bin/mopidy"]
