module QuizGame
  class ProcessSubmittedAnswer
    def initialize(game, session_id, answer)
      @game = game
      @session_id = session_id
      @answer = answer
    end

    def execute
      SubmittedAnswer.create({
        question: @answer.question,
        answer: @answer,
        session_id: @session_id.to_s
      })
    end
  end
end
