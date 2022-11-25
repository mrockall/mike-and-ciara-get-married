class Game < ApplicationRecord
  FORMAT = {
    quiz: 'quiz'
  }

  has_many :questions
  has_many :enabled_questions, -> { where(enabled: true) }, class_name: 'Question'

  def url
    "/games/#{self.key}"
  end

  def status_for_session(session_id)
    QuizGame::GetStatusForSession.new(self, session_id).execute
  end
end
