# Preview all emails at http://localhost:3000/rails/mailers/answer_mailer
class AnswerMailerPreview < ActionMailer::Preview

  # Preview this email at http://localhost:3000/rails/mailers/answer_mailer/notify_about_answer
  def notify_about_answer
    AnswerMailer.notify_about_answer
  end

end
