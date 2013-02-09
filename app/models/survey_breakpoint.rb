class SurveyBreakpoint < ActiveRecord::Base
	belongs_to :survey
	has_many :survey_breakpoint_result

	has_one :previous_survey_breakpoint, :class_name => "SurveyBreakpoint",
    :foreign_key => "next_survey_breakpoint_id"
  belongs_to :next_survey_breakpoint, :class_name => "SurveyBreakpoint"

end
