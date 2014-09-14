require 'spec_helper'

describe Crawlette::Crawler do
  subject(:crawler) { Crawlette::Crawler.new('http://example.com') }
  let(:root) { File.read('spec/files/root.html') }
  let(:s1) { File.read('spec/files/section-1.html') }
  let(:s2) { File.read('spec/files/section-2.html') }
  let(:s1_1) { File.read('spec/files/section-1-1.html') }


  describe '#crawl' do
    before do
      expect(Net::HTTP).to receive(:get).with(URI.parse('http://example.com')){ root }
      expect(Net::HTTP).to receive(:get).with(URI.parse('http://example.com/section-1')){ s1 }
      expect(Net::HTTP).to receive(:get).with(URI.parse('http://example.com/section-2')){ s2 }
      expect(Net::HTTP).to receive(:get).with(URI.parse('http://example.com/section-1-1')).twice{ s1_1 }
    end

    it "returns a hash with the crawled urls as keys and hashes with the links and assets of each one" do
      expect(crawler.crawl).to eq(
        "http://example.com" => {
          "links"=>["http://example.com/section-1", "http://example.com/section-2"],
          "assets"=>["http://example.com/styles.css"]
        },
        "http://example.com/section-2"=>{
          "links"=>["http://example.com/section-1-1"],
          "assets"=>["http://example.com/styles.css"]
        },
        "http://example.com/section-1"=>{
          "links"=>["http://example.com/section-1-1"],
          "assets"=>["http://example.com/styles.css"]
        },
        "http://example.com/section-1-1"=>{
          "links"=>[],
          "assets"=>["http://example.com/styles.css"]
        }
      )
    end
  end
end