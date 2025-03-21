FROM alpine:latest

RUN apk update && apk add --no-cache bash

COPY fecHora.sh /

CMD ["/bin/bash", "/fecHora.sh"]
