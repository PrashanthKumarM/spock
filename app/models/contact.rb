class Contact < ActiveRecord::Base

	belongs_to :user

	validates_presence_of :phone
	validates_uniqueness_of :phone

end
