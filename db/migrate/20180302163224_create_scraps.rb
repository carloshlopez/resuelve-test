class CreateScraps < ActiveRecord::Migration
  def change
    create_table :scraps do |t|
      t.date :start
      t.date :finis
      t.string :external_id

      t.timestamps null: false
    end
  end
end
