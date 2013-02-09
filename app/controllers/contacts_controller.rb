class ContactsController < ApplicationController

	before_filter :require_user
	
  def new
  	@contact = current_user.contacts.new 
  end

  def index
    @contacts = current_user.contacts.all
  end

  def edit
  	@contact = Contact.find params[:id]
  end

  def create
  	@contact = current_user.contacts.new(params[:contact])#.merge(:user_id => current_user.id))
  	if @contact.save
  		redirect_to contacts_path
  	else
      p @contact.errors
  		redirect_to new_contact_path
  	end
  end

  def update
  	@contact = current_user.contacts.find params[:id]
  	@contact.update_attributes params[:contact]
  	if @contact.save
  		redirect_to contacts_path
  	else
  		redirect_to edit_contact_path @contact.id
  	end
  end

  # def destroy
  # 	@contact = Contact.find params[:id]
  # 	@contact
  # end
end
