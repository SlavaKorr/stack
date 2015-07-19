class Answer < ActiveRecord::Base

  include Commentable
  include Attachable
  include Votable

  belongs_to :user
  belongs_to :question

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
