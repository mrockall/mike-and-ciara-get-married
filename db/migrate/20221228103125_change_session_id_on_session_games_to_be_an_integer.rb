class ChangeSessionIdOnSessionGamesToBeAnInteger < ActiveRecord::Migration[7.0]
  def change
    add_column :session_games, :new_session_id, :integer
  end
end
