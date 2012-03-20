require 'test_helper'

class CharityServiceControllerTest < ActionController::TestCase
  test "should get index with no params" do
    get :index
    assert_response :success
    assert_nil assigns(:charities)
    assert_nil assigns(:campaigns)
    assert_nil assigns(:search_terms)

    assert_select "form" do
      assert_select "[name=submit]", 1
      assert_select "input#search_terms", ""
    end

    assert_select "table", 0, "No tables since no results"
  end

  test "blank search should not assign charities or campaigns" do
    get :index, :search_terms => ""
    assert_response(:success)
    assert_nil assigns(:charities)
    assert_nil assigns(:campaigns)
    assert_equal assigns(:search_terms), ""

    assert_select "span#no_results"
    assert_select "table", 0, "No tables since no results"
  end

  test "search should display charities and campaigns" do
    get :index, :search_terms => "test"
    assert_response :success
    assert_not_nil assigns(:charities)
    assert_not_nil assigns(:campaigns)
    assert_equal assigns(:search_terms), "test"

    assert_select("input#search_terms") {|el| assert_equal el.first.attributes["value"], "test" }

    assert_select "span#no_results", 0
    # header + 10 rows/page
    assert_select "table#charities tr", 11
    # header + 10 rows/page
    assert_select "table#campaigns tr", 11
  end

  test "pagination controls" do
    require "#{Rails.root}/lib/CharityDataProvider.rb"
    campaign_names = Campaign.search("test").map {|c| c.name }
    charity_names = CharityDataProvider.search("test").map {|c| c[:orgName]}

    # Run for Campaigns/Charities separately to make sure they page on their own; make sure controls show up correctly.
    [
      {:table_id => "campaigns", :pages => Campaign.count/10, :names => campaign_names },
      {:table_id => "charities", :pages => CharityDataProvider.search("test").length/10, :names => charity_names }
    ].each do |obj|
      # First page
      get :index, :search_terms => "test"
      last_page_url = "#{request.path}?#{obj[:table_id]}_page=#{obj[:pages]}&amp;#{request.query_string}"

      assert_select "table##{obj[:table_id]} + nav.pagination" do
        assert_select "span.first a:content('&laquo; First')", 0
        assert_select "span.prev a:content('&lsaquo; Prev')", 0
        assert_select "span.page.current:content('1')"
        assert_select "span.page a[href='#{last_page_url}']:content('#{obj[:pages]}')"
        assert_select "span.next a[href='#{request.path}?#{obj[:table_id]}_page=2&amp;#{request.query_string}']:content('Next &rsaquo;')"
        assert_select "span.last a[href='#{last_page_url}']:content('Last &raquo;')"
      end
      obj[:names][0..9].each do |name|
        # Make sure all the names show up in the first column
        assert_select "table##{obj[:table_id]} td:first-child:content('#{name}')"
      end

      # Middle
      get :index, :search_terms => "test", :"#{obj[:table_id]}_page" => 3
      last_page_url = "#{request.path}?#{obj[:table_id]}_page=#{obj[:pages]}&amp;#{request.query_string}"

      assert_select "table##{obj[:table_id]} + nav.pagination" do
        assert_select "span.first a[href='#{request.path}?#{request.query_string}']:content('&laquo; First')"
        assert_select "span.prev a[href='#{request.path}?#{obj[:table_id]}_page=2&amp;#{request.query_string}']:content('&lsaquo; Prev')"
        assert_select "span.page.current:content('3')"
        assert_select "span.page a[href='#{last_page_url}']:content('#{obj[:pages]}')"
        assert_select "span.next a[href='#{request.path}?#{obj[:table_id]}_page=4&amp;#{request.query_string}']:content('Next &rsaquo;')"
        assert_select "span.last a[href='#{last_page_url}']:content('Last &raquo;')"
      end
      obj[:names][20..29].each do |name|
        # Make sure all the names show up in the first column
        assert_select "table##{obj[:table_id]} tr td:first-child:content('#{name}')"
      end

      # Last Page
      get :index, :search_terms => "test", :"#{obj[:table_id]}_page" => obj[:pages]
      last_page_url = "#{request.path}?#{obj[:table_id]}_page=#{obj[:pages]}&amp;#{request.query_string}"

      assert_select "table##{obj[:table_id]} + nav.pagination" do
        assert_select "span.first a[href='#{request.path}?#{request.query_string}']:content('&laquo; First')"
        assert_select "span.prev a[href='#{request.path}?#{obj[:table_id]}_page=#{obj[:pages]-1}&amp;#{request.query_string}']:content('&lsaquo; Prev')"
        assert_select "span.page.current:content('#{obj[:pages]}')"
        assert_select "span.page a[href='#{last_page_url}']:content('#{obj[:pages]}')", 0
        assert_select "span.next a:content('Next &rsaquo;')", 0
        assert_select "span.last a[href='#{last_page_url}']:content('Last &raquo;')", 0
      end
      obj[:names][(obj[:pages]-1)*10..-1].each do |name|
        # Make sure all the names show up in the first column
        assert_select "table##{obj[:table_id]} tr td:first-child:content('#{name}')"
      end
    end
  end

  test "cancellation link" do
    cancellation_url = "http://www.google.com/"
    get :index, :cancellation_url => cancellation_url
    assert_select "a[href='#{cancellation_url}']:content('Cancel')"

    get :index
    assert_select "a[href='#{cancellation_url}']:content('Cancel')", 0
  end

  test "selection_url visibility/functionality" do
    selection_url = "http://www.google.com/"
    get :index, :search_terms => "test", :selection_url => selection_url

    Campaign.search("test").limit(10).each do |campaign|
      assert_select "table#campaigns a[href^='#{selection_url}?campaign_id=#{campaign.id}']:content('Select')"
    end
    CharityDataProvider.search("test")[0..9].each do |charity|
      assert_select "table#charities a[href^='#{selection_url}?charity_id=#{charity[:ein]}']:content('Select')"
    end

    get :index, :search_terms => "test"
    # No selection_url passed, so no "Select" links shown.
    assert_select "table a:content('Select')", 0
  end
end

