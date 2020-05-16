class CreateAssignments < ActiveRecord::Migration[6.0]
  def change
    create_table :assignments do |t|
      t.text :description
      t.datetime :start_date
      t.datetime :dead_line
      t.references :user, null: false, foreign_key: true
      t.references :project, null: false, foreign_key: true
      t.integer :rating
      t.boolean :completed, default: false
      t.boolean :accepted, default: false
      t.boolean :rejected, default: false

      t.timestamps
    end
  end
end
