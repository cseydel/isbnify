require 'rubygems'
require 'bundler/setup'
require 'nokogiri'
require "fakeweb"
require 'vcr'
require 'simplecov'
require 'simplecov-gem-adapter'

SimpleCov.start do
  add_filter 'spec'
  add_filter 'vendor'
end

require 'isbnify'

VCR.configure do |c|
  c.cassette_library_dir = 'spec/cassettes'
  c.hook_into :fakeweb
  c.configure_rspec_metadata!
end

RSpec.configure do |config|
  config.around(:each) do |example|
    options = example.metadata[:vcr] || {}
    if options[:record] == :skip
      VCR.turned_off(&example)
    else
      name = example.metadata[:full_description].split(/\s+/, 2).join("/").gsub!(/(.)([A-Z])/,'\1_\2').downcase!.gsub(/[^\w\/]+/, "_") rescue "something"
      VCR.use_cassette(name, options, &example)
    end
  end
end

class Test
  include Isbnify
end