require "spec_helper"

describe Isbnify::IISBNA do
  describe "with instance methods" do
    it "parses a xml" do
      Isbnify::IISBNA.new.xml_parse.should be_kind_of(Hash)
    end
  end
end