class AddAvailableAfterDateToGames < ActiveRecord::Migration[7.0]
  def change
    add_column :games, :available_after_date, :date
  end
end
