class AddLastStartToScrap < ActiveRecord::Migration
  def change
    add_column :scraps, :last_start, :date
  end
end
