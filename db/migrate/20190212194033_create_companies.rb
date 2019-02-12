class CreateCompanies < ActiveRecord::Migration[5.0]
  def change
    create_table :companies do |t|
      t.string :name
      t.text :description
      t.string :company_url
      t.string :logo_url
  end
end
