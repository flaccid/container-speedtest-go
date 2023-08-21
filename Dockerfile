FROM alpine AS builder
ENV VERSION=1.6.3
RUN apk add --update --no-cache curl && \
	cd /tmp && \
 	curl -vL --remote-name https://github.com/showwin/speedtest-go/releases/download/v${VERSION}/speedtest-go_${VERSION}_Linux_i386.tar.gz && \
 	tar zxvf speedtest-go_${VERSION}_Linux_i386.tar.gz

FROM scratch
COPY --from=builder /tmp/speedtest-go /opt/speedtest-go/speedtest
COPY --from=builder /etc/ssl/certs/ca-certificates.crt /etc/ssl/certs/ca-certificates.crt
CMD ["/opt/speedtest-go/speedtest"]
