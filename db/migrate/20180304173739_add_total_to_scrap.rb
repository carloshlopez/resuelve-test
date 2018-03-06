class AddTotalToScrap < ActiveRecord::Migration
  def change
    add_column :scraps, :total, :integer
  end
end
