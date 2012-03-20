class Campaign < ActiveRecord::Base

  def self.search(search_terms)
    # To be implemented later
    self.where(true)
  end

  def get_image_url
    # To be implemented later
    "http://rubyonrails.org/images/rails.png"
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

