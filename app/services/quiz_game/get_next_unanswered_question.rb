module QuizGame
  class GetNextUnansweredQuestion
    def initialize(game, session_id)
      @game = game
      @session_id = session_id
    end

    def execute
      question_ids = @game.enabled_questions.in_order.pluck(:id)
      
      query = SessionGameAnswer.joins(session_game: [:session])
      query = query.where(question_id: question_ids)
      query = query.where(session_games: {sessions: {session_id: @session_id.to_s}})
      questions_with_answers = query.pluck(:question_id)

      Question.in_order.where(id: question_ids - questions_with_answers).first
    end
  end
end
