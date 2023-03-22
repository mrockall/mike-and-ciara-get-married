class ApplicationController < ActionController::Base
  before_action :pass_the_session_id_to_the_view
  before_action :check_if_games_are_enabled
  before_action :get_next_three_games

  def index
    
  end

  def details_of_the_day
    @page_title = "Details of the Day"
  end

  def where_to_stay
    @page_title = "Where to Stay"
  end

  def hair_and_make_up
    @page_title = "Hair & Make Up"
  end

  def rsvp
    @page_title = "RSVP"
  end

  def change_of_chapel
    @page_title = "Change of Chapel"
  end

  private

  def pass_the_session_id_to_the_view
    @session_id = session.id
  end

  def check_if_games_are_enabled
    @games_are_enabled = Game.where(enabled: true).any?
  end

  def get_next_three_games
    @next_games = Game.order(Arel.sql('RANDOM()')).where(enabled: true).limit(3)
  end
end
