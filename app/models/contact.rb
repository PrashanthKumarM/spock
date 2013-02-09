class Contact < ActiveRecord::Base

	belongs_to :user
	attr_protected :user_id

	validates_presence_of :name, :phone
	validates_uniqueness_of :phone


end
