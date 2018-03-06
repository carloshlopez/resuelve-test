class ChangeFinisToFinishInScrap < ActiveRecord::Migration
  def change
    rename_column :scraps, :finis, :finish
  end
end
