module QuizGame
  class ProcessSubmittedAnswer
    def initialize(game, session_id, answer)
      @game = game
      @session_id = session_id.to_s
      @answer = answer
    end

    def execute
      session = find_or_create_session
      return unless session.present?

      session_game = find_or_create_session_game(session)
      return unless session_game.present?

      existing_answer = SessionGameAnswer.where({
        session_game: session_game,
        question: @answer.question
      })
      return if existing_answer.present?
      
      SessionGameAnswer.create!({
        session_game: session_game,
        question: @answer.question,
        answer: @answer
      })

      if @answer.is_correct
        session_game.increment :count_correct
      else
        session_game.increment :count_incorrect
      end

      remaining_count = @game.enabled_questions.count - session_game.count_correct - session_game.count_incorrect
      session_game.update_attribute :count_remaining, remaining_count
    end

    private

    def find_or_create_session
      Session.find_or_create_by({
        session_id: @session_id
      })
    end

    def find_or_create_session_game(session)
      SessionGame.find_or_create_by({
        game: @game,
        session_id: session.id
      })
    end
  end
end
