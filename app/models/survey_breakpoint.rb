class SurveyBreakpoint < ActiveRecord::Base
	belongs_to :survey
	has_many :survey_breakpoint_result
end
