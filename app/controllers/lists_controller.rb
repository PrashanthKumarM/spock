class ListsController < ApplicationController
	before_filter :require_user

	def new
		@list = List.new
		@contacts = Contact.find(:all, :conditions => { :user_id => current_user.id })
	end

	def show
		@list = List.find(params[:id])
	end

	def create
		@list = List.new(params[:list])
		@contacts = Contact.find(:all, :conditions => { :id => params[:ids] })
		if @list.save and @contacts.update_all({:list_number => @list.id})
			flash[:notice] = "List saved successfully"
		else
			flash[:error] = "List not saved"
		end
		redirect_to account_path
	end

	def index
		@lists = current_user.lists
	end

	def destroy
		@list = List.find(params[:id])
		if @list.destroy
			flash[:notice] = "List destroyed successfully"
		else
			flash[:error] = "List not destroyed"
		end
		redirect_to account_path
	end

end