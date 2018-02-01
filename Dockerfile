FROM alpine:3.7

ENV SSL_PATH "/ssl"
ENV SSL_CRT_NAME "ssl.crt"
ENV SSL_KEY_NAME "ssl.key"
ENV SSL_CA_NAME "ca.crt"

RUN ln -sf /dev/stdout /var/log/docker.out.log
RUN ln -sf /dev/stderr /var/log/docker.err.log

COPY entrypoint.sh /
RUN chmod a+x entrypoint.sh

WORKDIR "/etc/traefik"
ENTRYPOINT ["/entrypoint.sh"]
CMD ["init"]
