class Answer < ActiveRecord::Base

  belongs_to :user
  belongs_to :question
  has_many   :attachments, as: :attachable

  accepts_nested_attributes_for :attachments 

  validates :question_id, presence: true
  validates :body, length: { in: 10..1000 }
  validates :user_id, presence: true

  default_scope { order('best_answer DESC') }

  def best
    ActiveRecord::Base.transaction do
      self.question.answers.update_all(best_answer: false)
      self.update(best_answer: true)
    end
  end
end
