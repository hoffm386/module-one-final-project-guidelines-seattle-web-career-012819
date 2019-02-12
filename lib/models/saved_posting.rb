class SavedPosting < ActiveRecord::Base
  belongs_to :job_hunter, foreign_key: 'job_hunter_id'
  belongs_to :job_posting, foreign_key: 'job_posting_id'

end
