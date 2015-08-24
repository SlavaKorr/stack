class AnswerMailer < ApplicationMailer

  def notify_about_answer(user)
    @user = user
    mail to: @user.email, subject: "Hey! It's answer for your question"
  end
end
