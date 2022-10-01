class CreateSubmittedAnswers < ActiveRecord::Migration[7.0]
  def change
    create_table :submitted_answers do |t|
      t.integer :question_id
      t.integer :answer_id
      t.string :session_id

      t.timestamps
    end
  end
end
