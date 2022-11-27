class SessionGame < ApplicationRecord

  STATUSES = {
    not_started: 'not_started',
    in_progress: 'in_progress',
    finished: 'finished'
  }

  belongs_to :game
  has_many :session_game_answers

  validates_presence_of :game

  before_create :set_defaults
  before_save :update_status
  after_save :queue_email_if_finished

  # before_create
  def set_defaults
    self.status = STATUSES[:not_started]
    self.count_correct = 0
    self.count_incorrect = 0
    self.count_remaining = game.enabled_questions.count
  end

  # before_save
  def update_status
    if self.count_correct == 0 && self.count_incorrect == 0
      self.status = STATUSES[:not_started]
    elsif self.count_remaining == 0
      self.status = STATUSES[:finished]
    else      
      self.status = STATUSES[:in_progress]
    end
  end

  # after_save
  def queue_email_if_finished
    return unless self.status == STATUSES[:finished]
    QuizMailer.with(session_game: self).quiz_completed_notification.deliver_later
  end
end
