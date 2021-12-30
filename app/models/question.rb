class Question < ApplicationRecord

  belongs_to :category
  has_many :answers, dependent: :destroy
  has_one :correct_answer, -> { where(is_correct: true) }, class_name: 'Answer'

  validates_presence_of :category, :text

end
