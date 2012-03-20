ENV["RAILS_ENV"] = "test"
require File.expand_path('../../config/environment', __FILE__)
require 'rails/test_help'

class ActiveSupport::TestCase
  # Setup all fixtures in test/fixtures/*.(yml|csv) for all tests in alphabetical order.
  #
  # Note: You'll currently still have to declare fixtures explicitly in integration tests
  # -- they do not yet inherit this setting
  fixtures :all

  # Add more helper methods to be used by all tests here...
end

module HTML
   class Tag < Node
      def text
         return @content if respond_to? :content
         data=""
         0.upto(children.size-1) {|i|
             next if children[i].respond_to?:name and children[i].name=="script"
             data += children[i].text
         }
         return data
      end

      def inner_html
         data = ""
         children.each {|e| data += e.to_s}
         data
       end
   end
end

