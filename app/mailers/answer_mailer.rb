class AnswerMailer < ApplicationMailer

  def notify_about_answer(answer)
    @answer = answer
    mail to: @answer.question.user.email, subject: "Hey! It's answer for your question"
  
    @answer.question.subscriptions.find_each.each do |subscription|
    mail to: @subscription.user.email, subject: "Hey! It's answer for question"
    end
  end
end
