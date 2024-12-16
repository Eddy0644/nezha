FROM alpine AS certs
RUN apk update && apk add ca-certificates

FROM busybox:stable-musl

ARG TARGETOS
ARG TARGETARCH

COPY --from=certs /etc/ssl/certs /etc/ssl/certs
COPY ./script/entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

WORKDIR /dashboard
#COPY dist/dashboard-${TARGETOS}-${TARGETARCH} ./app
# Download Nezha dashboard directly from GitHub releases
RUN wget https://github.com/nezhahq/nezha/releases/download/v1.2.2/dashboard-linux-amd64.zip \
    && unzip dashboard-linux-amd64.zip \
    && mv dashboard-linux-amd64 ./app \
    && rm dashboard-linux-amd64.zip

ARG TZ=Asia/Shanghai
ENV TZ=$TZ
ENTRYPOINT ["/entrypoint.sh"]
