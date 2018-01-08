FROM logstash:latest
WORKDIR /root
COPY . .

# Download dumps
RUN wget https://nyc3.digitaloceanspaces.com/imdbnator/imdb.movies.tar.gz
RUN tar xvzf imdb.movies.tar.gz

# Install Python.
RUN \
  apt-get update && \
  apt-get install -y python python-dev python-pip python-virtualenv && \
  rm -rf /var/lib/apt/lists/*

WORKDIR /root/scripts
    virtualenv env && \
    source env/bin/activate && \
    pip install -r requirements.txt && \
    python parser.py tmdb movies ../tmdb.movies ../
    python parser.py imdb movies ../imdb.movies ../
    deactivate
WORKDIR /root
