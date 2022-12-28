module QuizGame
  class GetStatusForSession
    def initialize(game, session_id)
      @game = game
      @session_id = session_id.to_s
    end

    def execute
      session_game = SessionGame.joins(:session).where({
        game: @game,
        sessions: {session_id: @session_id}
      }).first

      return :not_started if session_game.nil?

      session_game.status.to_sym
    end
  end
end
