# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
campaigns = Campaign.create([
  { charity_id: 3, name: "Compassion campaign 1", description: "Suspendisse ornare tincidunt sapien id eleifend. Integer vel." },
  { charity_id: 3, name: "Compassion campaign 2", description: "Suspendisse vestibulum, dui ut blandit interdum, arcu leo."},
  { charity_id: 1, name: "United Way campaign 1", description: "Vestibulum vestibulum, nibh non elementum vestibulum, sapien urna."},
  { charity_id: 5, name: "Campaign with no Charity", description: "Suspendisse potenti. Nunc rhoncus justo sit amet ipsum."}
])

