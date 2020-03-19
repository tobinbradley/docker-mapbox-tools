FROM node:10.19.0-buster-slim

# install packages
RUN apt update \
 && apt -y --no-install-recommends install \
    ca-certificates \
    build-essential \
    git \
    libsqlite3-dev \
    zlib1g-dev \
# Tippecanoe
 && mkdir -p /tmp/tippecanoe-src \
 && git clone https://github.com/mapbox/tippecanoe.git /tmp/tippecanoe-src \
 && cd /tmp/tippecanoe-src \
 && make \
 && make install \
 && cd ../ \
 && rm -rf /tmp/tippecanoe-src \
# Fontnik
 && npm -g config set user root \
 && npm install -g fontnik \
# spritezero
 && npm install -g @mapbox/spritezero glob \
# Clean up
 && apt purge -y git build-essential \
 && rm -rf /var/lib/apt/lists/*

# Copy scripts
WORKDIR /scripts
COPY scripts/sprite.sh /scripts/sprite.sh
COPY scripts/font.sh /scripts/font.sh
COPY scripts/sprite.js /scripts/sprite.js
RUN chmod +x /scripts/sprite.sh
RUN chmod +x /scripts/font.sh

# Set paths
ENV NODE_PATH="/usr/local/lib/node_modules"
ENV PATH="/scripts:${PATH}"

# Set default working directory
WORKDIR /data

# set default command
CMD ["bash"]