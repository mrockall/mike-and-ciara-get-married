class Answer < ApplicationRecord

  belongs_to :question
  has_many :session_game_answers

  validates_presence_of :text
  
end
