class GamesController < ActionController::Base
  layout 'application'
  before_action :check_if_games_are_enabled

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
    @session_id = session.id

    @question = QuizGame::GetNextUnansweredQuestion.new(@game, @session_id).execute

    if @question.present?
      render 'games/question'
    else
      render 'games/recap'
    end
  end

  # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - 

  private

  def check_if_games_are_enabled
    @games_are_enabled = Game.where(enabled: true).any?
  end
end
