class Agency < ActiveRecord::Base
	has_many :jobs
	belongs_to :organization
end
