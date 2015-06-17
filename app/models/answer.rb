class Answer < ActiveRecord::Base

  belongs_to :user
  belongs_to :question
  
  validates :question_id, presence: true
  validates :body, length: { in: 10..1000 }

end
