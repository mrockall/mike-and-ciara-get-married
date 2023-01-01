class Session < ApplicationRecord

  scope :leaderboard_order, -> { order("count_correct DESC, count_incorrect DESC, games_played DESC") }

  has_many :session_games

  before_create :set_defaults

  # before_create
  def set_defaults
    self.games_played = 0
    self.count_correct = 0
    self.count_incorrect = 0
  end

  # public
  def leaderboad_position
    query = Session.leaderboard_order
    query = query.where("count_correct > ?", count_correct)
    above_count = query.count 

    query = Session.leaderboard_order
    query = query.where("count_correct = ? AND count_incorrect > ?", count_correct, count_incorrect)
    tied_count = query.count 

    above_count + tied_count + 1
  end

  # public
  def percentage_correct
    return 0.0 if count_correct + count_incorrect == 0

    ((count_correct / (count_correct + count_incorrect).to_f) * 100).round
  end
end
