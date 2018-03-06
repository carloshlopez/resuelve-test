class AddSearchIdToScrap < ActiveRecord::Migration
  def change
    add_reference :scraps, :search, index: true, foreign_key: true
  end
end
