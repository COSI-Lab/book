# build
FROM rust:latest as builder

RUN apt update && apt upgrade -y && apt install graphviz -y

ENV CARGO_REGISTRIES_CRATES_IO_PROTOCOL=sparse
RUN cargo install --no-default-features --features search mdbook
RUN cargo install mdbook-graphviz

WORKDIR /book
COPY . .

RUN mdbook build

# serve
FROM nginx:latest

COPY nginx.conf /etc/nginx/nginx.conf

COPY --from=builder /book/book /usr/share/nginx/html

RUN ["nginx"]
