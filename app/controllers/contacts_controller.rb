class ContactsController < ApplicationController
  def new
  	@contact = Contact.new
  end

  def edit
  	@contact = Contact.find params[:id]
  end

  def create
  	@contact = Contact.new(params[:contact])
  	if @contact.save
  		redirect_to contacts_path
  	else
  		redirect_to edit_contact_path @contact.id
  	end
  end

  def update
  	@contact = Contact.find params[:id]
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
