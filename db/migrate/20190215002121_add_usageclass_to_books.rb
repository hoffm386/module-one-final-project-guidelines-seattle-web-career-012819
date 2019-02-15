class AddUsageclassToBooks < ActiveRecord::Migration[5.2]
  def change
    add_column :books, :usage_class, :string
  end
end
