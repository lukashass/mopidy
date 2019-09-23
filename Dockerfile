FROM debian:buster-slim

RUN apt-get update \
    && DEBIAN_FRONTEND=noninteractive apt-get install -y \
        curl \
        gnupg \
        python-crypto \
        gstreamer1.0-plugins-bad
RUN curl -L https://apt.mopidy.com/mopidy.gpg | apt-key add -
RUN curl -L https://apt.mopidy.com/mopidy.list -o /etc/apt/sources.list.d/mopidy.list
RUN apt-get update \
    && DEBIAN_FRONTEND=noninteractive apt-get install -y \
        mopidy \
        mopidy-local-sqlite \
        mopidy-soundcloud \
        mopidy-spotify \
        mopidy-tunein
RUN curl -L https://bootstrap.pypa.io/get-pip.py | python - \
    && pip install --upgrade six pyasn1 requests[security] cryptography \
    && pip install \
        https://github.com/natumbri/mopidy-youtube/archive/6deb7584434a676adce7b3365c61a90f17de9017.zip \
        pyopenssl \
        Mopidy-Iris \
        Mopidy-Local-Images

# Clean-up
RUN apt-get purge --auto-remove -y \
        curl
RUN apt-get clean
RUN rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* ~/.cache

# Default configuration.
COPY mopidy.conf /var/lib/mopidy/.config/mopidy/mopidy.conf

ENV HOME=/var/lib/mopidy

VOLUME ["/var/lib/mopidy"]

EXPOSE 6600 6680

CMD ["/usr/bin/mopidy"]
