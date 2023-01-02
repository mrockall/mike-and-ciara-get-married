class GamesController < ActionController::Base
  layout 'application'
  before_action :check_if_games_are_enabled
  before_action :pass_the_session_to_the_view
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

    unless @my_sesh.name.present?
      session[:redirected_from_game] = @game.id
      return redirect_to("/games/add-name") 
    end

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

  def leaderboard
    query = Session.leaderboard_order
    query = query.where('count_correct > 0')
    query = query.limit(20)
    @sessions = query.to_a

    unless @sessions.map(&:session_id).include?(@my_sesh.session_id)
      @sessions.push(@my_sesh)
    end
  end

  def add_name
    @page_title = "Add your Name | Games"
    @redirected_from_game = session[:redirected_from_game]
    @current_name = @my_sesh.name
    session[:redirected_from_game] = nil
  end

  def handle_add_name
    @my_sesh.name = params[:name]
    @my_sesh.save

    game = Game.where(id: params[:redirect_to_game]).first

    if game.present?
      redirect_to(game.url)
    else
      redirect_to("/games")
    end
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

  def pass_the_session_to_the_view
    @session_id = session.id
    @my_sesh = Session.find_or_create_by(session_id: @session_id.to_s)
  end

  def get_next_three_games
    @next_games = Game.order(Arel.sql('RANDOM()')).where(enabled: true).limit(3)
  end
end
