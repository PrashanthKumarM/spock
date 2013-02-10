class SurveyBreakpointsController < ApplicationController

	require 'twilio-ruby'

	def handle
		p "DON DON DON"
		@params = params

		initiate_survey_variables
		create_survey_result unless @params[:digits].nil?
		# unless @survey_breakpoint.next_survey_breakpoint_id.nil?	
			send_twiml_response 
		# else
		# 	render :text => Twilio::TwiML::Response.new do |r| r.Say "Thank You" end
		# end
	end

	protected

		def initiate_survey_variables
			puts "No user"
			@survey = Survey.find @params[:current_survey]
			@survey_result = @survey.survey_results.find @params[:current_survey_result]
			@survey_breakpoint = @survey.survey_breakpoints.find @params[:current_survey_breakpoint]
		end

		def create_survey_result 
			@previous_survey_breakpoint = @survey_breakpoint.previous_survey_breakpoint
			@survey_breakpoint_result = @survey_result.survey_breakpoint_results.new({ :result => @params[:digits], :survey_breakpoint_id => @previous_survey_breakpoint.id })
			@survey_breakpoint_result.save
		end

		def send_twiml_response 
			@next_survey_breakpoint = @survey_breakpoint.next_survey_breakpoint
			@path = "#{handle_survey_breakpoints_path}?current_survey=#{@survey.id}&current_survey_result=#{@survey_result.id}&current_survey_breakpoint=#{@next_survey_breakpoint.id}" unless @next_survey_breakpoint.nil?
			render :text => gen_xml(@path, @survey_breakpoint.twiml, true)
		end

		def gen_xml (path1, twiml, voice=true)
			numdigits = voice ? 1 : 9
			Twilio::TwiML::Response.new do |r|
				r.Gather :numDigits => '1', :action => path1, :method => 'get' do |g| 		
					g.Say twiml
				end
			end.text
		end

end