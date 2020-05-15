class AddLabelToAssignment < ActiveRecord::Migration[6.0]
  def change
    add_column :assignments, :label, :string
  end
end
