class CreateSearches < ActiveRecord::Migration
  def change
    create_table :searches do |t|
      t.string :external_id
      t.date :start
      t.date :finish
      t.string :result, default: "Working"

      t.timestamps null: false
    end
  end
end
