class ChangeNewSessionIdToBeRealSessionIdOnSessionGames < ActiveRecord::Migration[7.0]
  def change
    rename_column :session_games, :session_id, :old_string_session_id
    rename_column :session_games, :new_session_id, :session_id
  end
end
