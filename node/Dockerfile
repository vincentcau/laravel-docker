FROM library/node:12.21.0-alpine3.12

RUN apk add python3 && \
    apk add git && \
    apk add make && \
    apk add --upgrade g++ && \
    apk add --no-cache su-exec && \
    addgroup bar && \
    adduser -D -h /home -s /bin/sh -G bar foo && \
    echo 'PS1="Docker > php container $ "' > /home/.bashrc

COPY entrypoint.sh /sbin/entrypoint
RUN chmod +x /sbin/entrypoint

ENTRYPOINT ["entrypoint"]
