class ChangeCategoryIdToGameIdOnQuestions < ActiveRecord::Migration[7.0]
  def change
    rename_column :questions, :category_id, :game_id
  end
end
