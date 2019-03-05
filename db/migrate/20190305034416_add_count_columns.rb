class AddCountColumns < ActiveRecord::Migration[5.2]
  def change
    add_column :creators, :books_count, :integer, default: 0
    add_column :publishers, :creators_count, :integer, default: 0
  end
end
