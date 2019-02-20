class JobPosting < ActiveRecord::Base
  belongs_to :branch, foreign_key: 'branch_id'
  has_many :saved_postings
  has_many :applications

end
