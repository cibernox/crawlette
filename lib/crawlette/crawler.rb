require 'uri'
require 'net/http'
require 'crawlette/page'

module Crawlette
  class Crawler
    MAX_THREADS = 8
    BadUrlError = Class.new(ArgumentError)

    def initialize(url, sitemap = {})
      @uri = URI.parse(url)
      @pending_uris = [@uri]
      @sitemap = sitemap
      unless @uri.host && @uri.scheme
        fail BadUrlError, "Invalid url: You must provide a full qualified url"
      end
    end


    # Crawl a web page and generate a sitemap that must also contain:
    #
    # * Links betwenn pages.
    # * On which static assets each page depend on.
    #
    # Example:
    #
    # Crawlette::Crawler.new('https://gocardless.com').crawl
    # # => {
    #   'http://example.com/' => {
    #     'assets' => ['http://example.com/image1.png', 'http://example.com/script1.js', 'http://example.com/stylesheet1.css'],
    #     'links' => ['http://example.com/watch-a-demo', 'http://example.com/features'],
    #   },
    #   'http://example.com/watch-a-demo' => {
    #     'assets' => ['http://example.com/image2.png', 'http://example.com/script2.js', 'http://example.com/stylesheet2.css'],
    #     'links' => ['http://example.com/whatever1', 'http://example.com/whatever2'],
    #   },
    #   'http://example.com/features' => {
    #     'assets' => ['http://example.com/image3.png', 'http://example.com/script3.js', 'http://example.com/stylesheet3.css'],
    #     'links' => ['http://example.com/features/api', 'http://example.com/features/pricing'],
    #   },
    #   'http://example.com/features/api' => {
    #     ...
    #   },
    #   'http://example.com/features/pricing' => {
    #     ...
    #   },
    # }

    def crawl
      while @pending_uris.size > 0
        threads = []
        @pending_uris.pop(MAX_THREADS).each do |uri|
          threads << Thread.new { process_uri(uri) }
        end
        threads.each(&:join)
      end
      @sitemap
    end


    private

    def process_uri(uri)
      @sitemap[uri.to_s] ||= begin
        puts "... Fetching #{uri.to_s}"
        page = Page.new(Net::HTTP.get(uri), uri)
        more_uris = page.links.map { |url| URI.parse(url) }
        @pending_uris.push(*more_uris)
        { 'links'  => page.links, 'assets' => page.assets }
      end
    rescue => e
      puts "ERROR! Cannot fetch #{@uri}: #{e.message}"
    end
  end
end