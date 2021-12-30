class CreateAnswers < ActiveRecord::Migration[7.0]
  def change
    create_table :answers do |t|
      t.integer :question_id
      t.string :text
      t.boolean :is_correct

      t.timestamps
    end
  end
end
