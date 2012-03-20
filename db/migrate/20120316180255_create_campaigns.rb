class CreateCampaigns < ActiveRecord::Migration
  def change
    create_table :campaigns do |t|
      t.integer :charity_id
      t.string :name
      t.text :description
      t.datetime :start_at
      t.datetime :end_at
      t.boolean :is_active

      t.timestamps
    end
    add_index "campaigns", ["charity_id"], :name => "index_campaigns_on_charity_id"
  end
end

