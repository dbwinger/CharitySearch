class Campaign < ActiveRecord::Base

  def self.search(search_terms)
    # To be implemented later
    self.where(true)
  end

  def get_image_url
    # To be implemented later
    "rails.jpg"
  end

  def charity
    unless @charity
      @charity = Charity.find(charity_id)
      # Empty hash if nothing returned
      @charity = {} unless @charity
    end
    @charity
  end
end

