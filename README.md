# Crawlette

Very simple command line utility to crawl an URL and show the links and assets of each page.

## Installation

    $ gem install crawlette

## Usage

    $ crawlette http://miguelcamba.com

## Improvements

This approach discovers new pages and fetches them in batches of up to 8 pages using threads.
Probably a solution using EventMachine instead of threads would be more performant.

Since I haven't used any mutex or thread-safe data structures, there is a small chance that
any page is crawled twice unecessarily. Since the chance is small and that won't alter the result,
I just don't care.

This crawler has no limits, neither in number of links or its depth. Don't use it them to crawl
pages too big. Crawling twitter by example can be too much.