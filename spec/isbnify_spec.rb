require "spec_helper"

describe Isbnify, :vcr do
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
    it "delegates to ISBN.hyphinate_isbn" do
      Isbnify::ISBN.any_instance.should_receive(:hyphinate_isbn).once
      Test.hyphinate_isbn
    end

    it "delegates to ISBN.valid_isbn?" do
      Isbnify::ISBN.any_instance.should_receive(:valid_isbn?).once
      Test.valid_isbn?
    end

    it "delegates to ISBN.create_isbn" do
      Isbnify::ISBN.any_instance.should_receive(:create_isbn).once
      Test.create_isbn
    end
  end

end