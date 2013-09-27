require "spec_helper"

class Test
  include Isbnify
end

describe Isbnify do
  describe "with correct includes" do
    it "responds to hyphinate_isbn" do
      Test.should respond_to(:hyphinate_isbn)
    end

    it "responds to valid_isbn?" do
      Test.should respond_to(:valid_isbn?)
    end

    it "responds to valid_isbn?" do
      Test.should respond_to(:create_isbn)
    end
  end

  describe "with class methods" do
    context "with string_argument_validations" do
      it "raises ArgumentError on missing isbn_string" do
        expect { Test.hyphinate_isbn }.to raise_error(ArgumentError)
      end

      it "raises ArgumentError on missing isbn_string with message" do
        expect { Test.valid_isbn? }.to raise_error(ArgumentError, "expected argument not to be nil")
      end

      it "raises ArgumentError on not string object" do
        expect { Test.hyphinate_isbn(1) }.to raise_error(ArgumentError)
      end

      it "raises ArgumentError on not string object with message" do
        expect { Test.valid_isbn?(1) }.to raise_error(ArgumentError, "expected argument to be String")
      end
    end

    context "with integer_argument_validations" do
      it "raises ArgumentError on missing number" do
        expect { Test.create_isbn }.to raise_error(ArgumentError)
      end

      it "raises ArgumentError on missing number with message" do
        expect { Test.create_isbn }.to raise_error(ArgumentError, "expected argument not to be nil")
      end

      it "raises ArgumentError on not Integer number" do
        expect { Test.create_isbn("error") }.to raise_error(ArgumentError)
      end

      it "raises ArgumentError on not Integer number with message" do
        expect { Test.create_isbn("error") }.to raise_error(ArgumentError, "expected argument to be Integer")
      end
    end
  end

end