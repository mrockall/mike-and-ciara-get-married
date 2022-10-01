class ApplicationController < ActionController::Base
  before_action :check_if_games_are_enabled

  def index
    @question = Question.order(Arel.sql('RANDOM()')).first
  end

  def details_of_the_day
    @page_title = "Details of the Day"
  end

  def where_to_stay
    @page_title = "Where to Stay"
  end

  def rsvp
    @page_title = "RSVP"
  end

  def games

    redirect_to '/'
  end

  def church_game
    
  end

  private

  def check_if_games_are_enabled
    @games_are_enabled = Game.where(enabled: true).any?
  end
end
