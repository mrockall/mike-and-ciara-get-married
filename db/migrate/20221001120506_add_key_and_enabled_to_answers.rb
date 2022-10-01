class AddKeyAndEnabledToAnswers < ActiveRecord::Migration[7.0]
  def change
    add_column :answers, :key, :string
    add_column :answers, :enabled, :boolean
  end
end
