# Crawlette

Very simple command line utility to crawl an URL and show the links and assets of each page.

## Installation

    $ gem install crawlette

## Usage

    $ crawlette http://miguelcamba.com

## Improvements

This approach discovers new pages and fetches them in batches of up to 8 pages using threads.
Probably a solution using EventMachine instead of theards would be more performant.

Since I have used any mutex, there is a small chance that any page is crawled twice unecessarily.
Since the change is small and that won't alter the result, I just don't care.

This crawler has no limits, neigther in number of links or depth. Don't use it them to crawl
pages too big. Crawling twitter by example can be too much.