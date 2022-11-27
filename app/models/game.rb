class Game < ApplicationRecord
  FORMAT = {
    quiz: 'quiz'
  }

  has_many :session_games, dependent: :destroy
  has_many :questions, dependent: :destroy
  has_many :enabled_questions, -> { where(enabled: true) }, class_name: 'Question'

  def url
    "/games/#{self.key}"
  end

  def is_enabled_and_available?
    if self.available_after_date.present?
      return self.enabled && !Date.today.before?(self.available_after_date)
    end

    self.enabled
  end

  def status_for_session(session_id)
    QuizGame::GetStatusForSession.new(self, session_id).execute
  end
end
