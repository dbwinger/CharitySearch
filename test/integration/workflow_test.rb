require 'test_helper'

class WorkflowTest < ActionDiscpatch::IntegrationTest
  fixtures :all

  test "cancellation_url and selection_urls preserved after search" do
    cancellation_url = "http://www.cancel.com"
    selection_url = "http://www.select.com"
    get "charity_service/index", :cancellation_url => cancellation_url, :selection_url => selection_url
  end
end

