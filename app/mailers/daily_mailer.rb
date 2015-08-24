class DailyMailer < ApplicationMailer
                  
  def digest(user)
    @user = user
    @questions = Question.where("created_at >= ?", Time.zone.now.beginning_of_day)
    mail(to: @user.email, subject: "Hi, it's daily digest for you")
  end
end
