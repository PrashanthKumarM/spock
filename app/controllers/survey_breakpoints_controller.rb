class SurveyBreakpointsController < ApplicationController

	def handle
		p "DON DON DON" 
		@params = params
		p @params

		initiate_survey_variables
		create_survey_result unless @params[:digits].nil?
		send_twiml_response unless @survey_breakpoint.next_survey_breakpoint_id.nil?	
	end

	protected

		def initiate_survey_variables
			@survey = current_user.surveys.find @params[:current_survey]
			@survey_result = @survey.survey_results.find @params[:current_survey_result]
			@survey_breakpoint = @survey.survey_breakpoints.find @params[:current_survey_breakpoint]
		end

		def create_survey_result 
			@previous_survey_breakpoint = @survey_breakpoint.previous_survey_breakpoint unless @survey_breakpoint.nil?
			@survey_breakpoint_result = @survey_results.survey_breakpoint_results.new({ :result => @params[:digits], :survey_breakpoint_id => @previous_survey_breakpoint.id })
			@survey_breakpoint_result.save
		end

		def send_twiml_response 
			p "just here"
			@next_survey_breakpoint = @survey_breakpoint.next_survey_breakpoint
			@path = "#{handle_survey_breakpoints_path}?current_survey=#{@survey.id}&current_survey_result=#{@survey_result.id}&current_survey_breakpoint=#{@next_survey_breakpoint.id}"
			@xml = gen_xml @path, @next_survey_breakpoint.twiml, true
			unless @next_survey_breakpoint.nil?
		    render :xml => @xml
		  end
		end

		def gen_xml(path, twiml, voice=true)
			numdigits = voice ? 1 : 9
			Twilio::TwiML::Response.new do |r|
				r.Gather :numDigits => '1', :action => path, :method => 'get' do |g| 		
					r.Say twiml
				end
			end.text
		end

end