class GamesController < ActionController::Base
  layout 'application'
  before_action :check_if_games_are_enabled
  before_action :pass_the_session_id_to_the_view

  def index
    enabled_games = Game.where(enabled: true)
    redirect_to('/') unless enabled_games.any?

    @page_title = "Games"
    @games = enabled_games.all
  end

  # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - 

  def game
    @game = Game.where(key: params[:key]).first
    return redirect_to("/games") unless @game.present?

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
    return redirect_to("/games") unless @game.present?

    @answer = Answer.where(id: params[:answer_id]).first
    return redirect_to("/games/#{@game.key}") unless @answer.present?

    @page_title = "#{@game.name} | Games"
    @question = @answer.question

    QuizGame::ProcessSubmittedAnswer.new(@game, @session_id, @answer).execute
  end

  def start_over
    reset_session
    redirect_back_or_to "/games"
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
