class GamesController < ActionController::Base
  layout 'application'
  before_action :check_if_games_are_enabled
  before_action :pass_the_session_id_to_the_view
  before_action :get_next_three_games

  def index
    enabled_games = Game.where(enabled: true).in_order
    redirect_to('/') unless enabled_games.any?

    @page_title = "Games"
    @games = enabled_games.all
  end

  # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - 

  def game
    @game = Game.where(key: params[:key]).first
    return redirect_to("/games") unless @game.present?
    return redirect_to("/games") unless @game.is_enabled_and_available?

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
    return redirect_to("/games") unless @game.is_enabled_and_available?

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

  def get_next_three_games
    @next_games = Game.order(Arel.sql('RANDOM()')).where(enabled: true).limit(3)
  end
end
