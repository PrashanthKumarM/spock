class SurveyBreakpointsController < ApplicationController

	def handle
		p "DON DON DON" 
		p params

		@survey = current_user.surveys.find params[:current_survey]
		@survey_result = @survey.survey_results.find params[:current_survey_result]
		
		#save the current result
		unless params[:digits].nil?
			# key = (params[:digits]>9) ? :value : :result
			@previous_survey_breakpoint = @survey_breakpoint.previous_survey_breakpoint
			@survey_breakpoint_result = @survey_results.survey_breakpoint_results.new({ :result => params[:digits], :survey_breakpoint_id => @previous_survey_breakpoint.id })
			@survey_breakpoint_result.save
		end

		#render
		@survey_breakpoint = @survey.survey_breakpoints.find params[:current_survey_breakpoint]
		@next_survey_breakpoint = @survey_breakpoint.next_survey_breakpoint
		unless @survey_breakpoint.next_survey_breakpoint.nil?	
			@url = "#{handle_survey_breakpoints_url}?current_survey=#{@survey.id}&current_survey_result=#{@survey_result.id}&current_survey_breakpoint=#{@next_survey_breakpoint.id}"
			@xml = gen_xml @url
			unless @next_survey_breakpoint.nil?
				respond_to do |format|
		      format.xml  do
		        render :xml => @xml
		      end
		    end
		  end
		end

	end

	protected

		def gen_xml url

		end

end