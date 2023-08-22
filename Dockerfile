FROM alpine AS builder
ARG VERSION=1.6.3
ARG ARCH=x86_64
RUN apk add --update --no-cache curl && \
	cd /tmp && \
 	curl -L --remote-name https://github.com/showwin/speedtest-go/releases/download/v${VERSION}/speedtest-go_${VERSION}_Linux_${ARCH}.tar.gz && \
 	tar zxvf speedtest-go_${VERSION}_Linux_${ARCH}.tar.gz

FROM scratch
COPY --from=builder /tmp/speedtest-go /opt/speedtest-go/speedtest
COPY --from=builder /etc/ssl/certs/ca-certificates.crt /etc/ssl/certs/ca-certificates.crt
CMD ["/opt/speedtest-go/speedtest"]
