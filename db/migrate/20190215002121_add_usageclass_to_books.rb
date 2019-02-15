class AddUsageclassToBooks < ActiveRecord::Migration[5.2]
  def change
    add_column :books, :usage, :string
  end
end
