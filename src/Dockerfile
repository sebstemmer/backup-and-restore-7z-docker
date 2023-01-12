FROM alpine:3.14
RUN apk add p7zip
ARG script
COPY $script /usr/local/bin
ENV script_env=$script
ENTRYPOINT sh /usr/local/bin/$script_env