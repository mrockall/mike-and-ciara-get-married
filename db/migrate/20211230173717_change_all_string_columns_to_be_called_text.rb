class ChangeAllStringColumnsToBeCalledText < ActiveRecord::Migration[7.0]
  def change
    remove_column :questions, :body
    add_column :questions, :text, :text
  end
end
