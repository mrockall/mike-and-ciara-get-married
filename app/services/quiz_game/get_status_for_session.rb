module QuizGame
  class GetStatusForSession
    def initialize(game, session_id)
      @game = game
      @session_id = session_id
    end

    def execute
      question_ids = @game.enabled_questions.pluck(:id)
      
      query = SubmittedAnswer.where(session_id: @session_id.to_s)
      query = query.where(question_id: question_ids)
      questions_with_answers = query.pluck(:question_id)

      remaining_questions = question_ids - questions_with_answers

      case remaining_questions.length
      when 0
        :finished
      when question_ids.length
        :not_started
      else
        :in_progress
      end
    end
  end
end
