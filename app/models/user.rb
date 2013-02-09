class User < ActiveRecord::Base
  acts_as_authentic
  has_many :contacts, :dependent => :destroy
  has_many :surveys, :dependent => :destroy
end