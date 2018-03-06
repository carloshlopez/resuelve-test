class AddInitialFinishToScrap < ActiveRecord::Migration
  def change
    add_column :scraps, :initial_finish, :date
  end
end
