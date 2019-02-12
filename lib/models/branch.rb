class Branch < ActiveRecord::Base
  belongs_to :company, foreign_key: 'company_id'
  has_many :job_postings

end
