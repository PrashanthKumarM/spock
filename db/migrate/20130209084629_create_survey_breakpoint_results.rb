class CreateSurveyBreakpointResults < ActiveRecord::Migration
  def self.up
    create_table :survey_breakpoint_results do |t|
      t.integer :result
      t.string :value
      t.integer :survey_id
      t.integer :survey_result_id
      t.integer :survey_breakpoint_id
      t.integer :contact_id
      t.integer :user_id

      t.timestamps
    end
  end

  def self.down
    drop_table :survey_breakpoint_results
  end
end
