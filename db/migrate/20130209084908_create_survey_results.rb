class CreateSurveyResults < ActiveRecord::Migration
  def self.up
    create_table :survey_results do |t|
      t.integer :status
      t.integer :total_breakpoints
      t.integer :survey_id
      t.integer :contact_id
      t.integer :user_id
      
      t.timestamps
    end
  end

  def self.down
    drop_table :survey_results
  end
end
