class CreateJobPostings < ActiveRecord::Migration[5.0]
  def change
    create_table :job_postings do |t|
      t.string :title
      t.text :description
      t.text :required_technologies
      t.string :employment_type
      t.string :application_link
      t.integer :branch_id
    end 
  end
end
