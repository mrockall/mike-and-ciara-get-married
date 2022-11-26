class SubmittedAnswer < ApplicationRecord

  belongs_to :answer
  belongs_to :question

  validates_uniqueness_of :question_id, scope: :session_id
  
end
