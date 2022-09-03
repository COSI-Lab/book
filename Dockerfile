From rust:latest as builder

RUN cargo install mdbook

WORKDIR /book
COPY . .

RUN mdbook build

# stage 0

From nginx:latest

COPY nginx.conf /etc/nginx/nginx.conf

COPY --from=builder /book/book /usr/share/nginx/html

RUN ["nginx"]

