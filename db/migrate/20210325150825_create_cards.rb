class CreateCards < ActiveRecord::Migration[6.1]
  def change
    create_table :cards do |t|
      t.string :name
      t.string :description
      t.string :trello_id
      t.references :list, null: false, foreign_key: true

      t.timestamps
    end
  end
end
