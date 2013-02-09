class SurveysResultsController < ApplicationController

	def initiate
		account_sid = 'ACc64d9ba6b024d108b9efd56d905b1c7f'
		auth_token = '1561a5d67c1c765ccbc0b5a76fc310e3'
		@client = Twilio::REST::Client.new account_sid, auth_token
		@call = @client.account.calls.create(
  	:from => '+1 567-623-8300',   # From your Twilio number
  	:to => '+91 9941751339',     # To any number
  	# Fetch instructions from this URL when the call connects
  	:url => handle_survey_results_path
  	#+"?survey_breakpoint=#{@}"
		)
	end

	def handle 
		p "Hariharan"
		p params
	end



end