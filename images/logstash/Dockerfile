ARG ELK_VERSION

# https://github.com/elastic/logstash-docker
FROM docker.elastic.co/logstash/logstash-oss:${ELK_VERSION}

# Add your logstash plugins setup here
# Example: RUN logstash-plugin install logstash-filter-json

RUN mkdir -p /usr/share/logstash/config && mkdir -p /usr/share/logstash/pipeline
COPY ./config/logstash.yml /usr/share/logstash/config/logstash.yml
COPY ./pipeline /usr/share/logstash/pipeline

COPY --chown=1000:0 ./entrypoint.sh /usr/share/logstash/entrypoint-custom.sh
RUN chmod 0755 /usr/share/logstash/entrypoint-custom.sh

ENTRYPOINT ["/usr/share/logstash/entrypoint-custom.sh"]