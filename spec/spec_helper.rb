require 'rubygems'
require 'bundler/setup'
require 'nokogiri'

require 'isbnify'

RSpec.configure do |config|
end

class Test
  include Isbnify
end