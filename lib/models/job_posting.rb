class JobPosting < ActiveRecord::Base
  belongs_to :branch 
  has_many :saved_postings
  has_many :applications

end
