FROM alpine:3.16.0

RUN	apk update && apk upgrade && apk add --no-cache \
  nginx openssl

# nginx SSL
RUN mkdir /etc/nginx/ssl
RUN openssl req -newkey rsa:4096 -x509 -sha256 -days 365 -nodes \
  -out /etc/nginx/ssl/youkim.pem \
  -keyout /etc/nginx/ssl/youkim.key \
  -subj "/C=KO/ST=Seoul/L=Seoul/O=42 School/OU=youkim/CN=youkim/"

# nginx config
RUN mkdir -p /run/nginx

COPY conf/nginx.conf /etc/nginx/http.d/default.conf
COPY conf/phpfpm.conf /etc/nginx/snippets/phpfpm.conf

# Start nginx
ENTRYPOINT ["nginx", "-g", "daemon off;"]
