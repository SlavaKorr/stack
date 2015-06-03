class AddIndexToAnswers < ActiveRecord::Migration
  def self.up
  	add_index :answers, :question_id
  end
end
