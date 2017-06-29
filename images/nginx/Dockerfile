FROM nginx:1.13.1

## Installing nginx and wget and eventually selinux
RUN apt-get update && apt-get install -y --no-install-recommends \
	wget\
	inotify-tools

ENV WORKDIR /www
WORKDIR $WORKDIR

COPY entrypoint /usr/bin
COPY onchange.sh /usr/bin/onchange

RUN chmod a+rx /usr/bin/onchange \
	&& chmod +x /usr/bin/entrypoint \
	&& mkdir -p $WORKDIR/nginx \
	&& rm -Rf /etc/nginx \
	&& apt-get autoremove -y \
	&& rm -r /var/lib/apt/lists/*

COPY ./conf /etc/nginx

# forward request and error logs to docker log collector
RUN ln -sf /dev/stdout /var/log/nginx/access.log \
	&& ln -sf /dev/stderr /var/log/nginx/error.log

ENTRYPOINT entrypoint

CMD ["nginx", "-g", "daemon off;"]