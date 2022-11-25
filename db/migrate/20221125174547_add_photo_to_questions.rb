class AddPhotoToQuestions < ActiveRecord::Migration[7.0]
  def change
    add_column :questions, :photo, :string
  end
end
