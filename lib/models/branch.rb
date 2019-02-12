class Branch < ActiveRecord::Base
  belongs_to :company, foreign_key: 'company_id'
  has_many :job_postings

  validates_uniqueness_of :name

end
