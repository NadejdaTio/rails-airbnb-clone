class AddColumnToGames < ActiveRecord::Migration[5.0]
  def change
    add_column :games, :max_number_players, :integer
  end
end
