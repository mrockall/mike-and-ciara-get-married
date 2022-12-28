class Question < ApplicationRecord

  scope :in_order, -> { order("position ASC") }

  belongs_to :game

  has_many :answers, dependent: :destroy
  has_many :enabled_answers, -> { where(enabled: true) }, class_name: 'Answer'
  has_one :correct_answer, -> { where(is_correct: true) }, class_name: 'Answer'

  has_many :session_game_answers

  validates_presence_of :game, :text

  def has_been_answered
    count_correct + count_incorrect > 0
  end

  def success_rate
    return 0 unless has_been_answered
    ((count_correct / (count_correct + count_incorrect).to_f) * 100).round
  end

  def get_answer_for_session(session_id)
    query = SessionGameAnswer.joins(session_game: [:session])
    query = query.where(question_id: self.id)
    query = query.where(session_games: {sessions: {session_id: session_id.to_s}})
    submitted_answer = query.first
    return nil unless submitted_answer.present?
    
    submitted_answer.answer
  end
end
