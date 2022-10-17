# book

An online copy of the COSI book is currently hosted at https://book.cosi.clarkson.edu.

> Invest in documentation and prefer simple solutions that are maintainable and transferable to others.

This repo is intended to be our new documentation solution for the labs. It's easy to serve, it's convenient to keep an offline copy, and it's backed with markdown.

## Development 

The COSI book is built with [mdbook](https://github.com/rust-lang/mdBook). Its highly recommended you skim over the [User Guide](https://rust-lang.github.io/mdBook/) to get a jist for how the tool works. If you would like to preview your changes while you code follow these steps to setup mdbook.

1. [Install](https://rustup.rs/) the rust programming lanague.
2. After setting up rust run `cargo install mdbook` to get the latest version of the tool.
3. Clone this repo.
4. Within the repo run `mdbook serve` to preview your changes
5. Document!

It's highly recommended that preview your changes being submitting changes. It is very easy to make formatting mistakes. 

In CI we use [typos](https://github.com/crate-ci/typos) to check for typos. It's a good tool!

## Deployment

Until we get a good webhook solution updates to this repo must be manually deployed on dubsdot2. 

As **root** on dubsdot2 run:

```
cd /opt/book
git pull
docker-compose up --build -d
```

If you notice `mdbook` has been updated and it needs to be recompiled run:
```
docker-compose build --no-cache
docker-compose up -d
```
