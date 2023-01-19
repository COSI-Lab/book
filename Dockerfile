FROM rust:latest as builder

RUN apt install graphviz
RUN cargo install mdbook --no-default-features --features search 
RUN cargo install mdbook-graphviz

WORKDIR /book
COPY . .

RUN mdbook build

# stage 0

FROM nginx:latest

COPY nginx.conf /etc/nginx/nginx.conf

COPY --from=builder /book/book /usr/share/nginx/html

RUN ["nginx"]

