class ExecuteSurveyController < ApplicationController

	def execute_survey
		@survey = Survey.find params[:id]
		@survey_result = @survey.survey_results.new
		# @survey_result = 
	end

	def new

	end
end