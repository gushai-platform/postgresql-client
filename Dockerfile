FROM alpine:3
RUN apk add --no-cache postgresql-client
ENTRYPOINT [ "psql" ]
