class Campaign < ActiveRecord::Base

  def self.search(search_terms)
    # To be implemented later
    self.where(true)
  end

  # Get the whole hash of the associated Charity
  def charity_hash
    unless @charity
      require "#{Rails.root}/lib/CharityDataProvider.rb"
      @charity = CharityDataProvider.find(charity_id)
      # Empty hash if nothing returned
      @charity = {} unless @charity
    end
    @charity
  end
end

