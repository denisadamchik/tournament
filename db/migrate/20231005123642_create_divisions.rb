class CreateDivisions < ActiveRecord::Migration[7.1]
  def change
    create_table :divisions do |t|
      t.integer :title

      t.timestamps
    end
  end
end
