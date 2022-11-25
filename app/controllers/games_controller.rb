class GamesController < ActionController::Base
  layout 'application'
  before_action :check_if_games_are_enabled
  before_action :pass_the_session_id_to_the_view

  def index
    enabled_games = Game.where(enabled: true)
    redirect(root_url) unless enabled_games.any?

    @page_title = "Games"
    @games = enabled_games.all
  end

  # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - 

  def game
    @game = Game.where(key: params[:key]).first
    redirect(root_url) unless @game.present?

    @page_title = "#{@game.name} | Games"

    @question = QuizGame::GetNextUnansweredQuestion.new(@game, @session_id).execute

    if @question.present?
      render 'games/question'
    else
      render 'games/recap'
    end
  end

  def submit_answer
    @game = Game.where(key: params[:key]).first
    redirect(root_url) unless @game.present?

    @answer = Answer.where(id: params[:answer_id]).first
    redirect(root_url) unless @answer.present?

    @page_title = "#{@game.name} | Games"

    QuizGame::ProcessSubmittedAnswer.new(@game, @session_id, @answer).execute

    if @answer.is_correct
      render 'games/correct'
    else
      render 'games/incorrect'
    end
  end

  # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - 

  private

  def check_if_games_are_enabled
    @games_are_enabled = Game.where(enabled: true).any?
  end

  def pass_the_session_id_to_the_view
    @session_id = session.id
  end
end
