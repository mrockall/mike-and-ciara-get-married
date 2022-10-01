# encoding: utf-8
# 
# Used to import the content for the games from a yaml file
# 
# The logic behind this import script, is that the yaml file represents
# the ideal configuration for the games, and then this service just
# has to represent that in the database. It does this by disabling
# everything as it goes, and re-enabling using keys.
# 
module Import
  class FromYaml
    def initialize
      config_path = File.join(Rails.root, "config", "games.yml")
      @config = YAML.load(File.read(config_path)).deep_symbolize_keys
    end

    def execute
      Game.update_all(enabled: false)

      @config.each do |game_key, game_data|
        game = Game.find_or_create_by(key: game_key)

        game.update_attribute(:enabled, true)
        game.update_attribute(:description, game_data[:description])
        game.update_attribute(:name, game_data[:name])

        import_questions_for_game(game, game_data[:questions])
      end
    end

    private

    def import_questions_for_game(game, questions)
      game.questions.update_all(enabled: false)

      questions.each do |question_key, question_data|
        question = Question.find_or_create_by(key: question_key)

        question.update_attribute(:text, question_data[:text])

        import_answers_for_question(question, question_data[:answers])
      end
    end

    def import_answers_for_question(question, answers)
      question.answers.update_all(enabled: false)

      answers.each do |answer_key, answer_data|
        answer = Answer.find_or_create_by(key: answer_key)

        answer.update_attribute(:text, answer_data[:text])
        answer.update_attribute(:is_correct, answer_data[:is_correct])
      end
    end
  end
end
