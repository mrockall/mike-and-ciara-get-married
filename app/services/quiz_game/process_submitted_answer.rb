module QuizGame
  class ProcessSubmittedAnswer
    def initialize(game, session_id, answer)
      @game = game
      @session_id = session_id
      @answer = answer
    end

    def execute
      existing_answer = SubmittedAnswer.where(question: @answer.question, session_id: @session_id.to_s)
      return if existing_answer.present?
      
      SubmittedAnswer.create!({
        question: @answer.question,
        answer: @answer,
        session_id: @session_id.to_s
      })

      send_quiz_completed_notification if quiz_is_now_completed?
    end

    private

    def send_quiz_completed_notification
      QuizMailer.with(game: @game, session_id: @session_id).quiz_completed_notification.deliver
    end

    def quiz_is_now_completed?
      enabled_question_ids = @game.enabled_question_ids

      # We can determine if the quiz is complete, if we have an answer for
      # every enabled question. The uniqueness constraint on the answer model
      # will ensure we only have one answer per question.
      query = SubmittedAnswer.where(session_id: @session_id.to_s)
      query = query.where(question_id: enabled_question_ids)
      query.count == enabled_question_ids.count
    end
  end
end
