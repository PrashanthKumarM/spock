class SurveysController < ApplicationController

	require 'twilio-ruby'
	before_filter :build_user, :only => [ :index, :new, :show, :create ]
	NUMBERS = ['+1 567-623-8300', '+1 832-564-3133']

	def index
		@surveys = @user.surveys
	end

	def new
		@survey = @user.surveys.new
	end

	def report
		@survey_results = current_user.survey_results.all
	end

	def create
		@survey = @user.surveys.create(params[:survey])
		@prev = nil
		
		params[:inputs].length.times.each do |count|
			count = count.to_s
			@twiml = parse_xml params[:inputs][count][:question], params[:inputs][count][:options]
			sb = @survey.survey_breakpoints.create :twiml => @twiml
			sb.previous_survey_breakpoint = @prev unless @prev.nil?
			@prev = sb
		end
		@survey.save
		redirect_to surveys_path
		# refactor_workflow
	end

	def show
		@survey = @user.surveys.find(params[:id])
		@breaks = @survey.survey_breakpoints.all
	end

	def initiate_list_survey
		@list = User.find(:all, :conditions => { :list_number => params[:list_number]})
		call_lists
	end

	def initiate
		params[:phone] = '+919884837794'
		@params = params

		initiate_survey_variables
		save_survey_result
		make_the_call
	end

	def call_lists
		@list.each_with_index do |l, i|
			@contact = l
			params.merge(:phone => @contact.phone)
			initiate_survey_variables
			save_survey_result
			make_the_call NUMBERS[0] if i.even?
			make_the_call NUMBERS[1] if i.odd?
		end
	end
	
	private

		def initiate_survey_variables
			@survey = current_user.surveys.find params[:id]
			@contact = current_user.contacts.find_or_create_by_phone :phone => params[:phone]
		end

		def save_survey_result
			@survey_result = @survey.survey_results.new({:contact_id => @contact.id, :user_id => current_user.id})
			@survey_result.save
		end

		def make_the_call number
			account_sid = 'ACc64d9ba6b024d108b9efd56d905b1c7f'
			auth_token = '1561a5d67c1c765ccbc0b5a76fc310e3'
			first_survey_breakpoint = @survey.survey_breakpoints.first

			@client = Twilio::REST::Client.new account_sid, auth_token
			@call = @client.account.calls.create ({
	  	:from => number,
	  	:to => @contact.phone,
	  	:url => "#{handle_survey_breakpoints_url}?current_survey=#{@survey.id}&current_survey_result=#{@survey_result.id}&current_survey_breakpoint=#{first_survey_breakpoint.id}"
  		})
		end

		def parse_xml question, options
			unless options.nil?
				options.each do |k, v|
					question<<". #{v[:input_text]}"
				end
			end
			question
		end

		def refactor_workflow

		end

		def build_user
			@user = current_user
		end
end