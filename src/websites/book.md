# Book

_updated: Dec 10th 2022_

> Invest in documentation and prefer simple solutions that are maintainable and transferable to others.

You're likely already familiar with the [COSI Book](https://book.cosi.clarkson.edu) since you're currently reading it. The book is currently hosted as a [docker](https://www.docker.com/) container on [Tiamat](../infrastructure/servers/tiamat.md). The sources for the book are version controlled at <https://github.com/COSI-Lab/book>. 

Information for how to contribute to the book should added to a separate page. 

Technically maintaining the book is very easy. Deployment is well documentated in the README and `mdbook` is consisely documented [here](https://rust-lang.github.io/mdBook/).

What is far more interesting about the book is it's history.

## History

The history of documentation in COSI teaching some interesting lessons. Here is some history on why our previous two methods of documentation eventually fell out of fashion for their maintainablity and transferablity. 

**Info Slash**

[Info Slash](https://gitea.cosi.clarkson.edu/COSI_Maintainers/info-slash) was the most recent attempt at a new documentation solution. It used [mkdocs](https://www.mkdocs.org) and struggled to take off because of 

- Generally required intimate knowledge of the system to use
- Very little "meta" documentation
- A fairly complicated workflow to deploy the site

Book is trying to address these issues by
- Making it as simple as possible to contribute. 
- _you're currently reading the meta documentation_.
- Deployment is triggered by building a docker container. 

One of the best ways to support the continuity of lab infrastructure is to contribute to the book and teach other how to contribute to the book. 

**Docs**

For most of COSI's history we ran a [mediawiki](https://www.mediawiki.org/wiki/MediaWiki) instance at <http://docs.cosi.clarkson.edu>. As far as we can tell the docs database goes back to [2007](http://docs.cslabs.clarkson.edu/mediawiki/index.php?title=Guiding_Principles&oldid=183). The information in docs should be preserved and that would make a good project for anyone willing. 

Docs is clearly no longer our defacto documentation tool after lasting multiple generations of COSI members, here is why.

- MediaWiki is backed by a proper SQL database that needs to be maintained in concert with the wiki.
- MediaWiki updates introduce breaking changes, you can generally only update 1 version at a time.
- There was not a good culture around keeping the version of MediaWiki modern.
- At somepoint the spirit of documentation was not fully passed down.
- Writing pages in MediaWiki is just not as easy as, say, markdown.

[mdBook](https://rust-lang.github.io/mdBook/) in our opinion is the more maintainable tool for documentation. It is very feature poor, however it renders to _static_ HTML, CSS, and Javascript. There is no "mdBook server" that will memory leak. There is just some service ([NGINX](https://nginx.org/) at the time of writing) that hosts unchanging content.

The longevity of Book remains to be seen. Any challenges to it's reign should carefully consider the history of documentation in the labs in an effort to not repeat the same mistakes.



