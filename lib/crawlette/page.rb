require 'nokogiri'

module Crawlette
  class Page
    MAILTO_REGEX = /^mailto:/
    attr_reader :uri

    def initialize(html, uri)
      @html = html
      @uri  = uri
    end

    def links
      @links ||= sanitize_urls(document.css('a[href]').map { |a| a["href"] })
    end

    def assets
      @assets ||= begin
        urls = document.css('[src]').map { |a| a["src"] }
        urls += document.css('link[rel="stylesheet"][href]').map { |a| a["href"] }
        urls += document.css('meta[name^="og:image"]').map { |a| a["content"] }

        sanitize_urls(urls, external_links: true)
      end
    end

    private

    def document
      @document ||= Nokogiri::HTML.parse(@html)
    end

    def sanitize_urls(urls, external_links: false)
      urls.reject { |url| url =~ MAILTO_REGEX }
        .map { |url| URI.parse(URI.escape(url.sub(/#.*$/, ''))) }
        .map do |uri|
          uri.host   ||= @uri.host
          uri.scheme ||= @uri.scheme
          uri.to_s.sub(/\/$/, '') if external_links || uri.host =~ /#{@uri.host}$/
        end.compact.uniq
    end
  end
end