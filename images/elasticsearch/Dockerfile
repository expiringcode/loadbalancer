ARG ELK_VERSION

# https://github.com/elastic/elasticsearch-docker
FROM docker.elastic.co/elasticsearch/elasticsearch-basic:${ELK_VERSION}

# Add your elasticsearch plugins setup here
# Example: RUN elasticsearch-plugin install analysis-icu
RUN mkdir -p /usr/share/elasticsearch/config
COPY ./config/elasticsearch.yml /usr/share/elasticsearch/config/elasticsearch.yml