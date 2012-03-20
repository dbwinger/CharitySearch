class CharityServiceController < ApplicationController
  def index
    @search_terms = params[:search_terms]
    if not @search_terms.blank?
      @campaigns = Campaign.search(@search_terms).page params[:campaigns_page]
      @charities = Charity.search @search_terms
      @charities = Kaminari.paginate_array(@charities).page params[:charities_page]
    end
    @selection_url = params[:selection_url]
    @cancellation_url = params[:cancellation_url]
  end
end

