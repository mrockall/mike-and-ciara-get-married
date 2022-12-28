class CreateSessions < ActiveRecord::Migration[7.0]
  def change
    create_table :sessions do |t|
      t.string :session_id
      t.string :name
      t.integer :games_played
      t.integer :count_correct
      t.integer :count_incorrect

      t.timestamps
    end
  end
end
