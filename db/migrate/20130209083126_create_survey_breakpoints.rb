class CreateSurveyBreakpoints < ActiveRecord::Migration
  def self.up
    create_table :survey_breakpoints do |t|
      t.string :twiml
      t.integer :survey_id

      t.timestamps
    end
  end

  def self.down
    drop_table :survey_breakpoints
  end
end
