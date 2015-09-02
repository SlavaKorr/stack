class Answer < ActiveRecord::Base

  include Commentable
  include Attachable
  include Votable

  belongs_to :user
  belongs_to :question, touch: true

  validates :question_id, presence: true
  validates :body, length: { in: 10..1000 }
  validates :user_id, presence: true

  after_create :notify

  default_scope { order('best_answer DESC') }

  def best
    ActiveRecord::Base.transaction do
      self.question.answers.update_all(best_answer: false)
      self.update(best_answer: true)
    end
  end

  private

  def notify
    NotifyAnswerJob.perform_later(self)
  end


end
