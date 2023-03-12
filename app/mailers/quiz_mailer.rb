class QuizMailer < ApplicationMailer
  def quiz_completed_notification
    @session_game = params[:session_game]
    @game = @session_game.game

    to = Rails.application.credentials.gmail.to.email
    subject = "#{@session_game.session.name} completed the #{@game.name} quiz"
    mail to: to, subject: subject
  end
end
