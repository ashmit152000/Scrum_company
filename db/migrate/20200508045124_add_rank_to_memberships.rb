class AddRankToMemberships < ActiveRecord::Migration[6.0]
  def change
    add_column :memberships, :rank, :string
  end
end
