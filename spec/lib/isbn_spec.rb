require "spec_helper"

describe Isbnify::ISBN do
  describe "as object" do
    it "is an ISBN object" do
      Isbnify::ISBN.new(1).should be_kind_of(Isbnify::ISBN)
    end
  end

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
    context "with string_argument_validations" do
      it "raises ArgumentError on missing isbn_string" do
        expect { Isbnify::ISBN.new.hyphinate_isbn }.to raise_error(ArgumentError)
      end

      it "raises ArgumentError on missing isbn_string with message" do
        expect { Isbnify::ISBN.new.valid_isbn? }.to raise_error(ArgumentError, "expected argument not to be nil")
      end

      it "raises ArgumentError on not string object" do
        expect { Isbnify::ISBN.new(1).hyphinate_isbn }.to raise_error(ArgumentError)
      end

      it "raises ArgumentError on not string object with message" do
        expect { Isbnify::ISBN.new(1).valid_isbn? }.to raise_error(ArgumentError, "expected argument to be String")
      end
    end

    context "with integer_argument_validations" do
      it "raises ArgumentError on missing number" do
        expect { Isbnify::ISBN.new.create_isbn }.to raise_error(ArgumentError)
      end

      it "raises ArgumentError on missing number with message" do
        expect { Isbnify::ISBN.new.create_isbn }.to raise_error(ArgumentError, "expected argument not to be nil")
      end

      it "raises ArgumentError on not Integer number" do
        expect { Isbnify::ISBN.new("error").create_isbn }.to raise_error(ArgumentError)
      end

      it "raises ArgumentError on not Integer number with message" do
        expect { Isbnify::ISBN.new("error").create_isbn }.to raise_error(ArgumentError, "expected argument to be Integer")
      end

      context "with isbn length validation" do
        it "validates too short ISBN and returns false" do
          expect { Isbnify::ISBN.new("978-3-404-16669").valid_isbn? }.to raise_error(ArgumentError)
        end

        it "validates malformed and too short ISBN and returns false" do
          expect { Isbnify::ISBN.new("978.3.404.16669").valid_isbn? }.to raise_error(ArgumentError, "expected argument to include exactly 13 digits")
        end

        it "validates too long ISBN and returns false" do
          expect { Isbnify::ISBN.new("978-3-404-16669-27").valid_isbn? }.to raise_error(ArgumentError)
        end

        it "validates malformed and too long ISBN and returns false" do
          expect { Isbnify::ISBN.new("978.3.404.16669.27").valid_isbn? }.to raise_error(ArgumentError, "expected argument to include exactly 13 digits")
        end
      end
    end

    context "with valid_isbn?" do
      it "validates correct ISBN and returns true" do
        Isbnify::ISBN.valid_isbn?("978-3-404-16669-5").should be_true
      end

      it "validates incorrect ISBN and returns false" do
        Isbnify::ISBN.valid_isbn?("978-3-404-16669-7").should be_false
      end

      it "validates malformed correct ISBN and returns true" do
        Isbnify::ISBN.valid_isbn?("978.3.404.16669.5").should be_true
      end

      it "validates malformed and incorrect ISBN and returns false" do
        Isbnify::ISBN.valid_isbn?("ISBN 978/3/404/16669/7").should be_false
      end
    end

  end
end