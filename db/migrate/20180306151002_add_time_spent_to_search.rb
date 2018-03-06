class AddTimeSpentToSearch < ActiveRecord::Migration
  def change
    add_column :searches, :time_spent, :integer
  end
end
