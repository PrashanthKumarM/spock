class AddListNumberToContacts < ActiveRecord::Migration
  def self.up
  	add_column :contacts, :list_id, :integer
  end

  def self.down
  	remove_column :contacts, :list_number
  end
end
