# build
FROM rust:latest as builder

ENV CARGO_REGISTRIES_CRATES_IO_PROTOCOL=sparse
RUN cargo install --no-default-features --features search mdbook

WORKDIR /book
COPY . .

RUN mdbook build

# serve
FROM nginx:latest

COPY nginx.conf /etc/nginx/nginx.conf

COPY --from=builder /book/book /usr/share/nginx/html

RUN ["nginx"]
