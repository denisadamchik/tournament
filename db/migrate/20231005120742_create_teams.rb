class CreateTeams < ActiveRecord::Migration[7.1]
  def change
    create_table :teams do |t|
      t.string :name, null: false
      t.integer :division
      t.boolean :active, default: true
      t.integer :points, null: false, default: 0

      t.timestamps
    end
  end
end
