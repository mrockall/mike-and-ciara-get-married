class RenameTypeToFormatOnGames < ActiveRecord::Migration[7.0]
  def change
    rename_column :games, :type, :format
  end
end
