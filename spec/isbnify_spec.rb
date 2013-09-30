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

  describe "with response item" do
    let(:isbn) { "9783404166695" }

    it "delegates to ISBN.hyphinate_isbn" do
      Test.hyphinate_isbn(isbn).should be_kind_of(String)
    end

    it "delegates to ISBN.valid_isbn?" do
      Test.valid_isbn?(isbn).should be_kind_of(TrueClass)
    end

    it "delegates to ISBN.create_isbn" do
      Test.create_isbn.should be_kind_of(String)
    end
  end

end