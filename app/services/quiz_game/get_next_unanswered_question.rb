module QuizGame
  class GetNextUnansweredQuestion
    def initialize(game, session_id)
      @game = game
      @session_id = session_id
    end

    def execute
      question_ids = @game.enabled_questions.pluck(:id)
      
      query = SessionGameAnswer.joins(:session_game)
      query = query.where(question_id: question_ids)
      query = query.where(session_games: {session_id: @session_id.to_s})
      questions_with_answers = query.pluck(:question_id)

      Question.where(id: question_ids - questions_with_answers).first
    end
  end
end
