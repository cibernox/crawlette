$LOAD_PATH << File.join(File.dirname(__FILE__), "..", "lib")

require 'rspec'
require 'crawlette'

RSpec.configure do |config|
  config.filter_run(focus: true)
  config.run_all_when_everything_filtered = true
  config.order = 'random'
end