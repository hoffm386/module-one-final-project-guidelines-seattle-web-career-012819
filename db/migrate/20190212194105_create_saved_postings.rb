class CreateSavedPostings < ActiveRecord::Migration[5.0]
  def change
    create_table :saved_postings do |t|
      t.integer :job_hunter_id
      t.integer :job_posting_id 
  end
end
