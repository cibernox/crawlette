require 'spec_helper'

describe Crawlette::Page do
  subject(:page) { Crawlette::Page.new(html, URI.parse('https://gocardless.com')) }
  let(:html) { File.read('spec/files/page.html') }

  describe '#links' do
    it "returns a unique list of normalized non-external urls" do
      expected_links = [
        "https://gocardless.com/users/sign_in",
        "https://gocardless.com/merchants/new",
        "https://gocardless.com/watch-a-demo",
        "https://gocardless.com/features",
        "https://help.gocardless.com",
        "https://gocardless.com/contact-sales",
        "https://gocardless.com/faq/merchants",
        "https://gocardless.com/direct-debit",
        "https://gocardless.com/direct-debit/sepa",
        "https://gocardless.com/security",
        "https://developer.gocardless.com",
        "https://gocardless.com/legal",
        "https://gocardless.com/about",
        "https://gocardless.com/jobs",
        "https://gocardless.com/press",
        "https://gocardless.com/blog",
      ]
      expect(page.links).to match_array(expected_links)
    end
  end

  describe '#assets' do
    it 'returns a unique list with the normalized urls of the static assets on this page' do
      expected_assets = [
        "https://cdn.optimizely.com/js/125150657.js",
        "https://pdlvimeocdn-a.akamaihd.net/45126/030/267925344.mp4",
        "https://platform.twitter.com/widgets.js",
        "https://gocardless.com/images/footer/footer-logos@2x.png",
        "https://gocardless.com/js/vendor.js",
        "https://gocardless.com/js/main.js",
        "https://www.googletagmanager.com/gtm.js?id=GTM-PRFKNC",
        "https://gocardless.com/css/main.css",
        "https://gocardless.com/css/fonts.css",
        "https://gocardless.com/images/logos/gocardless-square.png"
      ]

      expect(page.assets).to match_array(expected_assets)
    end
  end
end