require "isbnify/version"
require "isbnify/isbn"

module Isbnify

  def self.included(base)
    base.extend(ClassMethods)
  end

  module ClassMethods
    def hyphinate_isbn(isbn_string = nil)
      ISBN.hyphinate_isbn(isbn_string)
    end

    def valid_isbn?(isbn_string = nil)
      ISBN.valid_isbn?(isbn_string)
    end

    def create_isbn(number = nil)
      ISBN.create_isbn(number)
    end

  end
end
