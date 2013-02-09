class Survey < ActiveRecord::Base
	belongs_to :user
	has_many :survey_breakpoints
	has_many :survey_results
	has_many :survey_breakpoint_results

	def trigger_survey
		
	end

	def run_survey contact_id
		
	end

end
