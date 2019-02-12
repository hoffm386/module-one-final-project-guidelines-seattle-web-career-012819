class SavedPosting < ActiveRecord::Base
  belongs_to :job_hunter
  belongs_to :job_posting 

end
