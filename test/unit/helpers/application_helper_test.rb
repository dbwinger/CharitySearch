require "test_helper"
require "#{File.dirname(__FILE__)}/../../../app/helpers/application_helper.rb"
class ApplicationHelperTest < ActionController::TestCase
  include ApplicationHelper

  test "append_query_string" do
    # With no other query string
    assert_equal "http://www.nothing.com?charity_id=3", self.append_query_string("http://www.nothing.com", "charity_id", "3")

    # Url that already has a query string
    assert_equal "http://www.nothing.com?something=88&charity_id=3", self.append_query_string("http://www.nothing.com?something=88", "charity_id", "3")
  end
end

