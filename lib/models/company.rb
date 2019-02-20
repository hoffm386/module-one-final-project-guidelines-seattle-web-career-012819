class Company < ActiveRecord::Base
  has_many :branches

  validates_uniqueness_of :name

end
