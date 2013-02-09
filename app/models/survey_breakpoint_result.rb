class SurveyBreakpointResult < ActiveRecord::Base
	belongs_to :user
	belongs_to :contact
	belongs_to :survey
	belongs_to :survey_breakpoint_result
	belongs_to :survey_result
end
