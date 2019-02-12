class JobHunter < ActiveRecord::Base
  has_many :saved_postings
  has_many :applications 

end
