class List < ActiveRecord::Base
	has_many :contacts
	belongs_to :user
	validates_uniqueness_of :name, :scope => :user_id
end