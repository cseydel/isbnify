require "spec_helper"

describe Isbnify::ISBN do
  describe "with class methods" do
    context "with string_argument_validations" do
      it "raises ArgumentError on missing isbn_string" do
        expect { Isbnify::ISBN.hyphinate_isbn }.to raise_error(ArgumentError)
      end

      it "raises ArgumentError on missing isbn_string with message" do
        expect { Isbnify::ISBN.valid_isbn? }.to raise_error(ArgumentError, "expected argument not to be nil")
      end

      it "raises ArgumentError on not string object" do
        expect { Isbnify::ISBN.hyphinate_isbn(1) }.to raise_error(ArgumentError)
      end

      it "raises ArgumentError on not string object with message" do
        expect { Isbnify::ISBN.valid_isbn?(1) }.to raise_error(ArgumentError, "expected argument to be String")
      end
    end

    context "with integer_argument_validations" do
      it "raises ArgumentError on missing number" do
        expect { Isbnify::ISBN.create_isbn }.to raise_error(ArgumentError)
      end

      it "raises ArgumentError on missing number with message" do
        expect { Isbnify::ISBN.create_isbn }.to raise_error(ArgumentError, "expected argument not to be nil")
      end

      it "raises ArgumentError on not Integer number" do
        expect { Isbnify::ISBN.create_isbn("error") }.to raise_error(ArgumentError)
      end

      it "raises ArgumentError on not Integer number with message" do
        expect { Isbnify::ISBN.create_isbn("error") }.to raise_error(ArgumentError, "expected argument to be Integer")
      end
    end
  end

  describe "with instance methods" do

  end
end