class CreateGames < ActiveRecord::Migration[5.0]
  def change
    create_table :games do |t|
      t.string :name
      t.text :description
      t.string :category
      t.integer :average_duration
      t.integer :number_players
      t.string :age_range
      t.float :price
      t.references :profile, foreign_key: true

      t.timestamps
    end
  end
end
