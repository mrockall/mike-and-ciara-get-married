class AddKeyAndEnabledToQuestions < ActiveRecord::Migration[7.0]
  def change
    add_column :questions, :key, :string
    add_column :questions, :enabled, :boolean
  end
end
