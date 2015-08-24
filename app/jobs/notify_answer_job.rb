class NotifyAnswerJob < ActiveJob::Base
  queue_as :default

  def perform(answer)
    answer.question.subscriptions.find_each do |subscription|
    AnswerMailer.notify_about_answer(subscription.user).deliver_later
    end
  end
end
