class RenameSubmittedAnswersToSessionGameAnswers < ActiveRecord::Migration[7.0]
  def change
    rename_table :submitted_answers, :session_game_answers
  end
end
