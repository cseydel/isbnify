module Isbnify
  class ISBN

    attr_accessor :param

    def initialize(param = nil)
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
      validate_checksum
    end

    def create_isbn
      integer_argument_validations(param)
    end


    private

    def has_isbn13_length?
      sanitize_isbn_string.length == 13
    end

    def validate_isbn_format

    end

    def sanitize_isbn_string
      param.gsub(/[^0-9]/, "")
    end

    def string_to_array(string)
      string[0..-2].split("")
    end

    def validate_checksum
      return false unless has_isbn13_length?
      validate_with_sanitized_string(sanitize_isbn_string)
    end

    def validate_with_sanitized_string(sanitized_string)
      sanitized_string[-1].to_i == calculate_checksum(sanitized_string)
    end

    def calculate_checksum(string)
      (10 - (inject_with_index(string_to_array(string)) % 10)) % 10
    end

    def inject_with_index(array)
      array.each_index.inject(0){ |sum, index| calculate_sum(sum, array[index].to_i, index + 1) }
    end

    def calculate_sum(sum, number, index)
      sum + exponate_number_with_index(number, index)
    end

    def exponate_number_with_index(number, index)
      number * (3 ** ((index + 1) % 2))
    end

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
      raise ArgumentError, "expected argument to be #{type}" unless attribute.is_a?(Module.const_get(type))
    end
  end
end