FROM debian:buster-slim

RUN apt-get update \
    && DEBIAN_FRONTEND=noninteractive apt-get install -y \
        curl \
        gnupg \
        python3-pip \
        gstreamer1.0-plugins-bad
RUN curl -L https://apt.mopidy.com/mopidy.gpg | apt-key add -
RUN curl -L https://apt.mopidy.com/buster.list -o /etc/apt/sources.list.d/mopidy.list
RUN apt-get update \
    && DEBIAN_FRONTEND=noninteractive apt-get install -y \
        mopidy
RUN python3 -m pip install \
        Mopidy-Iris \
        Mopidy-Local \
        Mopidy-MPD \
        Mopidy-SoundCloud \
        Mopidy-TuneIn \
        Mopidy-YouTube

# Clean-up
RUN apt-get purge --auto-remove -y \
        curl
RUN apt-get clean
RUN rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* ~/.cache

# Default configuration.
COPY mopidy.conf /var/lib/mopidy/.config/mopidy/mopidy.conf

ENV HOME=/var/lib/mopidy

EXPOSE 6600 6680

CMD ["/usr/bin/mopidy"]
