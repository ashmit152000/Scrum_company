class CreateProjects < ActiveRecord::Migration[6.0]
  def change
    create_table :projects do |t|
      t.string :name
      t.text :description
      t.datetime :start_date
      t.datetime :dead_line
      t.references :user, null: false, foreign_key: true
    end
  end
end
