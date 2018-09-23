FROM ubuntu:latest
RUN apt-get update -y && \
DEBIAN_FRONTEND=noninteractive && \
apt-get install wget -y && \
apt-get install build-essential -y && \
apt-get install libpcre3 libpcre3-dev zlib1g zlib1g-dev libssl-dev  -y
RUN wget http://nginx.org/download/nginx-1.15.3.tar.gz && \
tar -xvf nginx-1.15.3.tar.gz && \
cd nginx-1.15.3 && \
./configure \
--sbin-path=/usr/bin/nginx \
--conf-path=/etc/nginx/nginx.conf \
--error-log-path=/var/log/nginx/error.log \
--http-log-path=/var/log/nginx/access.log \
--with-pcre \
--pid-path=/var/run/nginx.pid \
--with-http_ssl_module && \
make && \
make install
RUN rm -f nginx-1.15.3.tar.gz
RUN rm -rf /nginx-1.15.3
EXPOSE 80 443
ENTRYPOINT /usr/bin/nginx -g 'daemon off;'