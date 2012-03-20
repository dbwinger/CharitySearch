class Charity
  def self.search(search_terms)
    # To be implemented later
    mock_data
  end

  # Find a specific charity by ein
  def self.find(ein)
    mock_data.select {|charity| charity[:ein] == ein}.first
  end

  def self.get_image_url(ein)
    # To be implemented later
  end

  private

  def self.mock_data
    data = []
    100.times do |i|
      data <<  {:ein => i, :orgName => "Charity #{i}", :description => "Lorem ipsum dolor sit amet, consectetur adipiscing elit."}
    end
    data
  end
end

