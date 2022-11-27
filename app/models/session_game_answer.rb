class SessionGameAnswer < ApplicationRecord

  belongs_to :session_game
  belongs_to :question
  belongs_to :answer

  validates_uniqueness_of :question_id, scope: :session_game
  
end
