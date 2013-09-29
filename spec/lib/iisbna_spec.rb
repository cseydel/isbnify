require "spec_helper"

describe Isbnify::IISBNA, :vcr do

  # valid isbn: 978-3-404-16669-5
  let(:isbn)                       { "9783404166695" }
  let(:check_isbn)                 { "9783551551672" }
  let(:invalid_isbn_prefix)        { "9713404166695" } # valid: 978, 979, here 971
  let(:invalid_isbn_country_group) { "9786404166695" } # valid: 0..5, here 6
  let(:invalid_isbn_publisher)     { "9786700166695" } # valid: 200..699, here 700

  describe "with instance methods" do
    context "on initialize" do
      it "assigns ISBN" do
        obj = Isbnify::IISBNA.new(isbn)
        obj.isbn.should eq isbn
      end

      it "assigns ISBN string as String" do
        obj = Isbnify::IISBNA.new(isbn)
        obj.isbn.should be_kind_of(String)
      end

      it "assigns ISBN number as String" do
        obj = Isbnify::IISBNA.new(isbn.to_i)
        obj.isbn.should be_kind_of(String)
      end

      it "assigns range_hash as Hash" do
        obj = Isbnify::IISBNA.new(isbn)
        obj.range_hash.should be_kind_of(Hash)
      end

      it "parses a xml" do
        Isbnify::IISBNA.any_instance.should_receive(:xml_parse).once
        Isbnify::IISBNA.new(isbn)
      end
    end

    context "with hyphinate" do
      context "with prefix" do
        it "shows no error message on valid prefix" do
          Isbnify::IISBNA.new(isbn).hyphinate.should_not eq ("invalid international ISBN13 number")
        end

        it "shows error message on invalid prefix" do
          Isbnify::IISBNA.new(invalid_isbn_prefix).hyphinate.should eq ("invalid international ISBN13 number")
        end

        it "assigns @prefix on valid prefix" do
          obj = Isbnify::IISBNA.new(isbn)
          obj.hyphinate
          obj.prefix.should eq "978"
        end

        it "not assigns @prefix on invalid prefix" do
          obj = Isbnify::IISBNA.new(invalid_isbn_prefix)
          obj.hyphinate
          obj.prefix.should be_nil
        end
      end

      context "with group" do
        it "shows no error message on valid group" do
          Isbnify::IISBNA.new(isbn).hyphinate.should_not eq ("invalid international ISBN13 number")
        end

        it "shows error message on invalid group" do
          Isbnify::IISBNA.new(invalid_isbn_country_group).hyphinate.should eq ("invalid international ISBN13 number")
        end

        it "assigns @country_group on valid country_group" do
          obj = Isbnify::IISBNA.new(isbn)
          obj.hyphinate
          obj.country_group.should eq "3"
        end

        it "not assigns @country_group on invalid country_group" do
          obj = Isbnify::IISBNA.new(invalid_isbn_country_group)
          obj.hyphinate
          obj.country_group.should be_nil
        end
      end

      context "with publisher" do
        it "shows no error message on valid publisher" do
          Isbnify::IISBNA.new(isbn).hyphinate.should_not eq ("invalid international ISBN13 number")
        end

        it "shows error message on invalid publisher" do
          Isbnify::IISBNA.new(invalid_isbn_country_group).hyphinate.should eq ("invalid international ISBN13 number")
        end

        it "assigns @publisher on valid publisher" do
          obj = Isbnify::IISBNA.new(isbn)
          obj.hyphinate
          obj.publisher.should eq "404"
        end

        it "not assigns @publisher on invalid publisher" do
          obj = Isbnify::IISBNA.new(invalid_isbn_country_group)
          obj.hyphinate
          obj.publisher.should be_nil
        end
      end

      context "with hyphens" do
        it "shows hyphinated isbn" do
          Isbnify::IISBNA.new(isbn).hyphinate.should eq "978-3-404-16669-5"
        end

        it "shows hyphinated check_isbn" do
          Isbnify::IISBNA.new(check_isbn).hyphinate.should eq "978-3-551-55167-2"
        end

        %w(9783847390688 9783847395720 9783659986185 9783639514971 9783639514957 9783639515152 9783659023606 9783659068058 9783659074646 9783659077647).each do |a_isbn|
          it "shoes correct isbn for #{a_isbn}" do
            Isbnify::IISBNA.new(a_isbn).hyphinate.should_not eq ("invalid international ISBN13 number")
          end
        end
      end
    end

    context "with create_valid_isbn" do
      it "creates isbn without error" do
        expect { Isbnify::IISBNA.new.create_valid_isbn }.not_to raise_error
      end

      it "creates isbn as String" do
        Isbnify::IISBNA.new.create_valid_isbn.should be_kind_of(String)
      end

      it "creates isbn as String" do
        isbn = Isbnify::IISBNA.new.create_valid_isbn
        isbn.gsub("-","").length.should eq 13
      end
    end
  end
end