class ApplicationController < ActionController::Base
  before_action :check_if_games_are_enabled

  def index
    
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
    enabled_games = Game.where(enabled: true)
    redirect "/" unless enabled_games.any?

    @page_title = "Games"
    @games = enabled_games.all
  end

  def game
    @game = Game.where(key: params[:key]).first
    redirect "/" unless @game.present?

    @page_title = "#{@game.name} | Games"
  end

  private

  def check_if_games_are_enabled
    @games_are_enabled = Game.where(enabled: true).any?
  end
end
