class QuizMailer < ApplicationMailer
  def quiz_completed_notification
    mail to: Rails.application.credentials.gmail.to.email, subject: "Someone completed a quiz!"
  end
end
