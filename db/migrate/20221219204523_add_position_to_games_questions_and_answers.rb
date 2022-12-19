class AddPositionToGamesQuestionsAndAnswers < ActiveRecord::Migration[7.0]
  def change
    add_column :games, :position, :integer
    add_column :questions, :position, :integer
    add_column :answers, :position, :integer
  end
end
