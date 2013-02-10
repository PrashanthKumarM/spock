class User < ActiveRecord::Base
	  acts_as_authentic
	  has_many :contacts, :dependent => :destroy
	  has_many :surveys, :dependent => :destroy
	  has_many :survey_results, :dependent => :destroy
	  has_many :survey_breakpoint_results, :dependent => :destroy
	  has_many :lists, :dependent => :destroy
end