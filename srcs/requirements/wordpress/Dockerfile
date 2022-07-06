FROM alpine:3.16.0

ADD https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar /usr/local/bin/wp
RUN chmod +x /usr/local/bin/wp

RUN apk add php8 php8-common php8-fpm php8-opcache \
  php8-gd php8-mysqli php8-zlib php8-curl php8-json \
  php8-phar php8-mbstring php8-session mysql-client curl

RUN sed -i 's|^listen = 127.0.0.1:9000$|listen = 9000|g' /etc/php8/php-fpm.d/www.conf
RUN sed -i 's|^;cgi.fix_pathinfo=1$|cgi.fix_pathinfo=0|g' /etc/php8/php.ini

COPY tools/configure.sh /scripts/run.sh
RUN chmod -R 755 /scripts

# static website
COPY conf/index.html /var/www/html/index.html


ENTRYPOINT ["/scripts/run.sh"]
