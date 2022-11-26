class QuizMailer < ApplicationMailer
  def quiz_completed_notification
    @game = params[:game]
    @session_id = params[:session_id]

    to = Rails.application.credentials.gmail.to.email
    subject = "Someone completed the #{@game.name} quiz"
    mail to: to, subject: subject
  end
end
