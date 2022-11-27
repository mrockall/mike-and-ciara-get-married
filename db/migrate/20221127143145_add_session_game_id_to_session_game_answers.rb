class AddSessionGameIdToSessionGameAnswers < ActiveRecord::Migration[7.0]
  def change
    add_column :session_game_answers, :session_game_id, :integer
    remove_column :session_game_answers, :session_id
  end
end
