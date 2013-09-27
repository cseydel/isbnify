module Isbnify
  class ISBN

    attr_accessor :param

    def initialize(param)
      @param = param
    end

    class << self
      def hyphinate_isbn(isbn_string = nil)
        self.new(isbn_string).hyphinate_isbn
      end

      def valid_isbn?(isbn_string = nil)
        self.new(isbn_string).valid_isbn?
      end

      def create_isbn(number = nil)
        self.new(number).create_isbn
      end
    end


    def hyphinate_isbn
      string_argument_validations(param)
    end

    def valid_isbn?
      string_argument_validations(param)
    end

    def create_isbn
      integer_argument_validations(param)
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
      raise ArgumentError, "expected argument to be #{type}" if not attribute.is_a?(Module.const_get(type))
    end
  end
end