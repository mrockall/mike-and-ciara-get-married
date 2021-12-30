class AddStatsColumnsToAnswersQuestionsAndCategories < ActiveRecord::Migration[7.0]
  def change
    add_column :categories, :count_correct, :integer, :default => 0
    add_column :categories, :count_incorrect, :integer, :default => 0
    add_column :questions, :count_correct, :integer, :default => 0
    add_column :questions, :count_incorrect, :integer, :default => 0
    add_column :answers, :count_chosen, :integer, :default => 0
  end
end
