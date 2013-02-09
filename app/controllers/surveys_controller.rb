class SurveysController < ApplicationController

	before_filter :require_user
	before_filter :build_user, :only => [ :index, :new, :show ]

	def index
		@surveys = @user.surveys
	end

	def new
		@survey = @user.surveys.new
	end

	def create
		@survey = @user.survey.new(params[:survey])
		params[:survey_body].each do |sb|

		end
	end

	def show
		@survey = @user.surveys.find_by_name(params[:survey_name])
	end

	def initiate_survey
		@list = User.find(:all, :conditions => { :list_number => params[:list_number]})
	end

	private

	def build_user
		@user = current_user
	end

end