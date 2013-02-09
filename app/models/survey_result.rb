class SurveyResult < ActiveRecord::Base
	belongs_to :contact
	belongs_to :user
	belongs_to :survey
	has_many :survey_breakpoint_results
end
