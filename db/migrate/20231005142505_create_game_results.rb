class CreateGameResults < ActiveRecord::Migration[7.1]
  def change
    create_table :game_results do |t|
      t.references :game, null: false, foreign_key: true
      t.references :team, null: false, foreign_key: true
      t.integer :points, null: false, default: 0
      t.integer :goals, null: false, default: 0

      t.timestamps
    end
  end
end
