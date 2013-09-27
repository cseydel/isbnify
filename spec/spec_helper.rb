require 'rubygems'
require 'bundler/setup'

require 'isbnify'

RSpec.configure do |config|
end

class Test
  include Isbnify
end