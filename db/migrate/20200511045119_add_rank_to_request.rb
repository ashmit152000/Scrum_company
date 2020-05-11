class AddRankToRequest < ActiveRecord::Migration[6.0]
  def change
    add_column :requests, :rank, :string
  end
end
