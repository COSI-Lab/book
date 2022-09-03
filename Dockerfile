From rust:1.63 as builder

RUN cargo install mdbook --no-default-features --features search --vers "^0.4"

WORKDIR /book
COPY . .

RUN mdbook build

# stage 0

From nginx:latest

COPY nginx.conf /etc/nginx/nginx.conf

COPY --from=builder /book/book /usr/share/nginx/html

RUN ["nginx"]

