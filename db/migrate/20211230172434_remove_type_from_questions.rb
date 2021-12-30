class RemoveTypeFromQuestions < ActiveRecord::Migration[7.0]
  def change
    remove_column :questions, :type
  end
end
