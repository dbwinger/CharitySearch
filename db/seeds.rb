# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

100.times do |charity_id|
  3.times do |campaign_num|
    Campaign.create(:charity_id => charity_id, :name => "Charity #{charity_id}::Campaign #{campaign_num}", :description => "Description of campaign #{campaign_num}")
  end
end

