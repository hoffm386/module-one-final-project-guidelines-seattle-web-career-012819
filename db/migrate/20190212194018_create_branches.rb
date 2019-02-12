class CreateBranches < ActiveRecord::Migration[5.0]
  def change
    create_table :branches do |t|
      t.string :name
      t.string :location
      t.integer :company_id
    end  
  end
end
