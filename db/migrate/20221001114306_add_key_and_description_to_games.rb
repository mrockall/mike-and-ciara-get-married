class AddKeyAndDescriptionToGames < ActiveRecord::Migration[7.0]
  def change
    add_column :games, :key, :string
    add_column :games, :description, :text
  end
end
