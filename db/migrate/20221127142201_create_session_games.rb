class CreateSessionGames < ActiveRecord::Migration[7.0]
  def change
    create_table :session_games do |t|
      t.string :session_id
      t.integer :game_id
      t.string :status
      t.integer :count_correct
      t.integer :count_incorrect
      t.integer :count_remaining

      t.timestamps
    end
  end
end
