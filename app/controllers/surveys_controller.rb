class SurveysController < ApplicationController

	# require 'twilio-ruby'
	before_filter :require_user
	before_filter :build_user, :only => [ :index, :new, :show ]

	def index
		@surveys = @user.surveys
	end

	def new
		@survey = @user.survey.new
	end

	def create
		@survey = @user.survey.new(params[:survey])
		params[:survey][:survey_breakpoints].each do |sb|
			@survey.survey_breakpoints.new (sb)
		end
		@survey.save
	end

	def show
		@survey = @user.surveys.find_by_name(params[:id])
	end

	def initiate_survey
		@list = User.find(:all, :conditions => { :list_number => params[:list_number]})
	end

	def initiate
		@survey = current_user.surveys.find params[:id]

		params[:phone] = '+919941751339'
		@contact = current_user.contacts.find_by_phone params[:phone]

		@survey_result = @survey.survey_results.new :contact_id => @contact.id

		account_sid = 'ACc64d9ba6b024d108b9efd56d905b1c7f'
		auth_token = '1561a5d67c1c765ccbc0b5a76fc310e3'

		first_survey_breakpoint = @survey.survey_breakpoints.first

		@survey_result.save
		@client = Twilio::REST::Client.new account_sid, auth_token
		
		p "#{@survey_result.id}"
		p "PEEKAY the mass"
		p  "#{handle_survey_breakpoints_url}?current_survey=#{@survey.id}&current_survey_result=#{@survey_result.id}&current_survey_breakpoint=#{first_survey_breakpoint.id}"

		@call = @client.account.calls.create ({
	  	:from => '+1 567-623-8300',
	  	:to => @contact.phone,
	  	:url => "#{handle_survey_breakpoints_url}?current_survey=#{@survey.id}&current_survey_result=#{@survey_result.id}&current_survey_breakpoint=#{first_survey_breakpoint.id}"
  	})
	end
	
	private

		def build_user
			@user = User.find(params[:id])
		end

end