class CreateJobHunters < ActiveRecord::Migration[5.0]
  def change
    create_table :job_hunters do |t|
      t.string :name
      t.text :skills
      t.string :location 
  end
end
