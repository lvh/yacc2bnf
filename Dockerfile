FROM alpine AS build
RUN apk add --update --no-cache --force-overwrite \
    openssl openssl-dev crystal shards g++ gc-dev \
    libc-dev libevent-dev libxml2-dev llvm llvm-dev \
    llvm-static make pcre-dev readline-dev \
    yaml-dev zlib-dev zlib llvm-libs
ADD yacc2bnf.cr shard.yml https://raw.githubusercontent.com/antlr/grammars-v4/master/c/C.g4 /
RUN shards install
RUN crystal run yacc2bnf.cr
#RUN crystal build yacc2bnf.cr --release --static

FROM scratch
COPY --from=build  yacc2bnf .
