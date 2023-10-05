class AddActiveAndPointsToTeams < ActiveRecord::Migration[7.1]
  def change
    add_column :teams, :points, :integer, default: 0
    add_column :teams, :active, :boolean, default: true
  end
end
