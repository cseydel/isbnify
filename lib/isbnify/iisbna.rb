require 'nokogiri'
require 'open-uri'

module Isbnify
  class IISBNA

    attr_accessor :isbn, :range_hash, :prefix, :country_group, :group_hash, :publisher

    def initialize(isbn = "")
      @isbn       = isbn.to_s
      @range_hash = xml_parse
    end

    def hyphinate
      return "invalid international ISBN13 number" unless valid_prefix? && valid_group? && valid_publisher?
      hyphinate_with_values
    end

    def create_valid_isbn
      random_group = range_hash[:"ISBNRangeMessage"][:"RegistrationGroups"][:"Group"].shuffle[0]
      group        = random_group[:Prefix]
      rule         = random_group[:Rules][:Rule].is_a?(Array) ? random_group[:Rules][:Rule].shuffle[0] : random_group[:Rules][:Rule]
      r_publisher  = random_publisher(rule)
      return create_isbn(group, r_publisher)
    end

    private

    def hyphinate_with_values
      product_id = isbn.gsub(/#{@prefix}#{@country_group}#{@publisher}/, "")
      return "#{@prefix}-#{@country_group}-#{@publisher}-#{product_id[0..-2]}-#{product_id[-1]}"
    end

    def valid_prefix?
      range_hash[:"ISBNRangeMessage"][:"EAN.UCCPrefixes"][:"EAN.UCC"].each do |prefix_hash|
        return @prefix = prefix_hash[:Prefix] if prefix_hash.has_value?(isbn[0..2])
      end
      false
    end

    def valid_group?
      checkstring = isbn.gsub(/^#{@prefix}/, "")
      range_hash[:"ISBNRangeMessage"][:"RegistrationGroups"][:"Group"].each do |group_hash|
        if group_prefix_included?(group_hash[:Prefix], checkstring)
          @group_hash = group_hash
          return @country_group = group_hash[:Prefix].gsub(/^#{@prefix}-/, "")
        end
      end
      false
    end

    def group_prefix_included?(prefix, checkstring)
      5.times do |n|
        return true if prefix == "#{@prefix}-#{checkstring[0..(n-1)]}"
      end
      false
    end

    def valid_publisher?
      checkstring = isbn.gsub(/#{@prefix}#{@country_group}/, "")
      @group_hash[:Rules][:Rule].each do |rule|
        return @publisher = checkstring[valid_range(rule[:Length])] if in_range?(rule, checkstring)
      end
    end

    def in_range?(rule, string)
      truncated_range(rule[:Range], rule[:Length], string[valid_range(rule[:Length])])
    end

    def truncated_range(range, length, needle)
      array = range.split("-")
      return needle.to_i.between?((array[0][valid_range(length)]).to_i, (array[1][valid_range(length)]).to_i)
    end

    def valid_range(length)
      (0..(length.to_i - 1))
    end

    def random_publisher(rule)
      array = rule[:Range].split("-")
      new_publisher  = (rand(array[1].to_i - array[0].to_i) + array[0].to_i).to_s
      return new_publisher[valid_range(rule[:Length])]
    end

    def create_isbn(group, r_publisher)
      product_size  = 12 - group.gsub("-","").size - r_publisher.size
      product       = "9999999999"[0..(product_size - 1)]
      checksum      = Isbnify::ISBN.create_isbn_checksum(group.gsub("-","") + r_publisher + product)
      return "#{group}-#{r_publisher}-#{product}-#{checksum}"
    end

    def xml_parse
      open_url_with_file_fallback.to_hash
    end

    def open_url_with_file_fallback
      begin
        xml_to_hash(open("http://www.isbn-international.org/agency?rmxml=1").read)
      rescue
        xml_to_hash(open(File.expand_path("../../../vendor/lib/RangeMessage.xml",  __FILE__)).read)
      end
    end

    # modified from http://stackoverflow.com/questions/1230741/convert-a-nokogiri-document-to-a-ruby-hash/1231297#123129
    def xml_to_hash(xml_io)
      result = Nokogiri::XML(xml_io)
      return { result.root.name.to_sym => xml_node_to_hash(result.root)}
    end

    def xml_node_to_hash(node)
      if node.element?
        parse_element(node)
      else
        return node.content.to_s
      end
    end

    def parse_element(node)
      result_hash = {}
      attributes = parse_attributes(node)
      if node.children.size > 0
        return result_hash = parse_children(node, attributes, result_hash)
      else
        return attributes
      end
    end

    def parse_attributes(node)
      if node.attributes != {}
        attributes = {}
        node.attributes.keys.each do |key|
          attributes[node.attributes[key].name.to_sym] = node.attributes[key].value
        end
      end
      attributes
    end

    def parse_children(node, attributes, result_hash)
      node.children.each do |child|
        result = xml_node_to_hash(child)
        if child.name == "text"
          unless child.next_sibling || child.previous_sibling
            return result unless attributes
            result_hash[child.name.to_sym] = result
          end
        elsif result_hash[child.name.to_sym]
          if result_hash[child.name.to_sym].is_a?(Object::Array)
             result_hash[child.name.to_sym] << result
          else
             result_hash[child.name.to_sym] = [result_hash[child.name.to_sym]] << result
          end
        else
          result_hash[child.name.to_sym] = result
        end
      end
      if attributes
        result_hash = attributes.merge(result_hash)
      end
      return result_hash
    end

  end
end