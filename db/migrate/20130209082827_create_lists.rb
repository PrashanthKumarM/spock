class CreateLists < ActiveRecord::Migration
  def self.up
  	create_table :lists do |f|
  		f.string :name
  		f.integer :user_id

  		f.timestamps
  	end
  end

  def self.down
  	drop_table :lists
  end
end
