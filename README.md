# book

An online copy of the COSI book is currently hosted at https://book.cosi.clarkson.edu.

> Invest in documentation and prefer simple solutions that are maintainable and transferable to others.

This repo is intended to be our new documentation solution for the labs. It's easy to serve, it's convenient to keep an offline copy, and pages are backed with markdown.

## Development 

The COSI book is built with [mdbook](https://github.com/rust-lang/mdBook). Skim over the [User Guide](https://rust-lang.github.io/mdBook/) to get a jist for how the tool works. Particularly the explanation on [SUMMARY.md](https://rust-lang.github.io/mdBook/format/summary.html).

1. Install the [rust](https://rustup.rs/) programming language.
2. After setting up rust run `cargo install mdbook --vers "^0.4"` to get the tool.
3. Optionally, install some dependencies:
	- `cargo install mdbook-graphviz` will install the Graphviz processor for writing diagrams in text (requires [Graphviz](https://graphviz.org/) on your system)
4. Clone this repo
5. Within the repo run `mdbook serve` to preview your changes
6. Document!

It's **highly** recommended that you preview your changes before submitting them. It is very easy to make formatting mistakes, mdbook may not exactly match other markdown processors.

In CI we use the [typos](https://github.com/crate-ci/typos) tool to check for typos. Recommended!

## Contributing

As long as the change isn't "trivial" you should always create a pull request. There is no requirement to fork the project, using a branch is preferred. If you aren't yet a part of our github team you should reach out to a Lab Director for an invite.

## Deployment

Until we get a good webhook solution all updates to this repo must be manually deployed on [dubsdot2](https://book.cosi.clarkson.edu/infrastructure/vms.html#dubsdot2). 

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
