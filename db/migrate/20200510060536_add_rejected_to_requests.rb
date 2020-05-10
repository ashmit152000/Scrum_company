class AddRejectedToRequests < ActiveRecord::Migration[6.0]
  def change
    add_column :requests, :rejected, :boolean,default: false
  end
end
