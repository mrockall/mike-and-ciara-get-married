module QuizGame
  class GetNextUnansweredQuestion
    def initialize(game, session_id)
      @game = game
    end

    def execute
      @game.questions.first
    end
  end
end