FROM alpine:3.16.0

ADD https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar /usr/local/bin/wp
RUN chmod +x /usr/local/bin/wp

COPY files/run.sh /scripts/run.sh
RUN chmod -R 755 /scripts

RUN apk add php7 php7-common php7-fpm php7-opcache php7-gd php7-mysqli php7-zlib php7-curl php7-json php7-phar php7-mbstring php7-session mysql-client curl
RUN sed -i 's|^listen = 127.0.0.1:9000$|listen = 9000|g' /etc/php7/php-fpm.d/www.conf
RUN sed -i 's|^;cgi.fix_pathinfo=1$|cgi.fix_pathinfo=0|g' /etc/php7/php.ini

EXPOSE 9000

ENTRYPOINT ["/scripts/run.sh"]
