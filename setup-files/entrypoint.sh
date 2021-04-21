#!/bin/bash

# Start avahi-daemon for network discovery
avahi-daemon --daemonize --no-drop-root

# https://superuser.com/questions/1539634/pulseaudio-daemon-wont-start-inside-docker
# Start the pulseaudio server
rm -rf /var/run/pulse /var/lib/pulse /root/.config/pulse
pulseaudio -D --verbose --exit-idle-time=-1 --system --disallow-exit


if [[ -v FORMAT ]]; then
    ./pipe-audio.sh
fi

if [[ -v HOST ]]; then
    ./snapcast.sh
fi

exec ledfx "$@"