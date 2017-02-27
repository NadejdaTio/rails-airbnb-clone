class ChangeColumnNumberPlayersGames < ActiveRecord::Migration[5.0]
  def change
    rename_column :games, :number_players, :min_number_players
  end
end
