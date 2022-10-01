module QuizGame
  class GetNextUnansweredQuestion
    def initialize(game, session_id)
      @game = game
      @session_id = session_id
    end

    def execute
      question_ids = @game.enabled_questions.pluck(:id)
      
      query = SubmittedAnswer.where(session_id: @session_id.to_s)
      query = query.where(question_id: question_ids)
      questions_with_answers = query.pluck(:question_id)

      Question.where(id: question_ids - questions_with_answers).first
    end
  end
end
