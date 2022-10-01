class Question < ApplicationRecord

  belongs_to :game
  has_many :answers, dependent: :destroy
  has_one :correct_answer, -> { where(is_correct: true) }, class_name: 'Answer'

  validates_presence_of :game, :text

  def has_been_answered
    count_correct + count_incorrect > 0
  end

  def success_rate
    return 0 unless has_been_answered
    ((count_correct / (count_correct + count_incorrect).to_f) * 100).round
  end

end
