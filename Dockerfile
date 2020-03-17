FROM node:10.19.0-buster

# install packages
RUN apt-get -y update && apt -y --no-install-recommends install build-essential

# Tippecanoe
RUN mkdir -p /tmp/tippecanoe-src
RUN git clone https://github.com/mapbox/tippecanoe.git /tmp/tippecanoe-src
WORKDIR /tmp/tippecanoe-src
RUN make && make install
WORKDIR /
RUN rm -rf /tmp/tippecanoe-src

# Fontnik
RUN npm -g config set user root && npm install -g fontnik

# spritezero
RUN npm -g config set user root && npm install -g @mapbox/spritezero glob

# Clean up
RUN apt-get -y remove build-essential && apt-get clean

# Copy scripts
RUN mkdir -p /scripts
COPY scripts/sprite.sh /scripts/sprite.sh
COPY scripts/sprite.js /scripts/sprite.js
RUN chmod +x /scripts/sprite.sh

# Set paths
ENV NODE_PATH="/usr/local/lib/node_modules"
ENV PATH="/scripts:${PATH}"

# Set default working directory
WORKDIR /data

# set default command
CMD ["bash"]