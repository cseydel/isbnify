require 'nokogiri'
require 'open-uri'

module Isbnify
  class IISBNA

    attr_accessor :xml

    def xml_parse
      open_url_with_file_fallback.to_hash
    end


    private

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