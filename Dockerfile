FROM alpine:3.4

MAINTAINER James White <dev.jameswhite@gmail.com>

COPY sphinx.conf /etc/sphinx/sphinx.conf

RUN echo "http://dl-5.alpinelinux.org/alpine/edge/testing" >> /etc/apk/repositories \
	&& apk --update add sphinx \
	&& mkdir -p /var/lib/sphinx \
	&& mkdir -p /var/lib/sphinx/data/bloggity_blog_post_core \
	&& mkdir -p /var/lib/sphinx/data/verse_core \
	&& mkdir -p /var/log/sphinx \
	&& mkdir -p /var/db/sphinx \
	&& mkdir -p /var/run/sphinx

# Expose 9312 for client connections, 9306 for SQL connections
EXPOSE 9312 9306

# scripts
RUN mkdir /usr/app

COPY searchd.sh  ./searchd.sh
COPY indexall.sh ./indexall.sh

RUN chmod a+x ./searchd.sh
RUN chmod a+x ./indexall.sh

# run the script
CMD ./indexall.sh