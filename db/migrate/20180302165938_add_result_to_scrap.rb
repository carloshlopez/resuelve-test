class AddResultToScrap < ActiveRecord::Migration
  def change
    add_column :scraps, :result, :string, default: "Working on it"
  end
end
