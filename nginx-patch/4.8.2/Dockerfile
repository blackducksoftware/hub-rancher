FROM blackducksoftware/hub-nginx:4.8.2

COPY diffs /etc/nginx/diffs
RUN /bin/sh /etc/nginx/diffs/patch-nginx-config.sh
