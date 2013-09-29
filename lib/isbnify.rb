require "isbnify/version"
require "isbnify/isbn"
require "isbnify/iisbna"

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

    def create_isbn
      ISBN.create_isbn
    end

  end
end
