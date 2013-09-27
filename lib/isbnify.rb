require "isbnify/version"

module Isbnify
  def self.included(base)
    base.extend(ClassMethods)
  end

  module ClassMethods
    def hyphinate_isbn(isbn_string = nil)
      string_argument_validations(isbn_string)
    end

    def valid_isbn?(isbn_string = nil)
      string_argument_validations(isbn_string)
    end

    def create_isbn(number = nil)
      integer_argument_validations(number)
    end


    private

    def string_argument_validations(isbn_string)
      validate_presence_of_attribute(isbn_string)
      validate_type_of_attribute(isbn_string, "String")
    end

    def integer_argument_validations(number)
      validate_presence_of_attribute(number)
      validate_type_of_attribute(number, "Integer")
    end

    def validate_presence_of_attribute(attribute)
      raise ArgumentError, "expected argument not to be nil" if attribute.nil?
    end

    def validate_type_of_attribute(attribute, type)
      raise ArgumentError, "expected argument to be #{type}" if not attribute.is_a?(const_get(type))
    end
  end
end
