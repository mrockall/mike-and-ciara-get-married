class ChangeIsCorrectDefaultToFalse < ActiveRecord::Migration[7.0]
  def change
    change_column_default :answers, :is_correct, false
  end
end
