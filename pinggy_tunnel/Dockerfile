FROM alpine:3.13

RUN apk add --no-cache openssh-client jq

COPY run.sh /run.sh
RUN chmod +x /run.sh

CMD [ "/run.sh" ]