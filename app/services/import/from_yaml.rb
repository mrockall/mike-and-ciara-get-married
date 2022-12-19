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
      Game.update_all(enabled: false, position: nil)

      @config.each_with_index do |game, position|
        game_key = game[0]
        game_data = game[1]

        game = Game.find_or_create_by({
          key: game_key
        })

        game.update_attribute(:enabled, true)
        game.update_attribute(:position, position)
        game.update_attribute(:description, game_data[:description])
        game.update_attribute(:name, game_data[:name])
        game.update_attribute(:format, game_data[:format])

        if game_data.has_key? :available_after_date
          game.update_attribute(:available_after_date, game_data[:available_after_date]) 
        end

        import_questions_for_game(game, game_data[:questions])
      end
    end

    private

    def import_questions_for_game(game, questions)
      game.questions.update_all(enabled: false, position: nil)

      questions.each_with_index do |question, position|
        question_key = question[0]
        question_data = question[1]

        question = Question.find_or_create_by({
          key: question_key,
          game_id: game.id
        })

        question.update_attribute(:enabled, true)
        question.update_attribute(:position, position)
        question.update_attribute(:text, question_data[:text])
        question.update_attribute(:photo, question_data[:photo]) if question_data.has_key? :photo

        import_answers_for_question(question, question_data[:answers])
      end
    end

    def import_answers_for_question(question, answers)
      question.answers.update_all(enabled: false, position: nil)

      answers.each_with_index do |answer, position|
        answer_key = answer[0]
        answer_data = answer[1]

        answer = Answer.find_or_create_by({
          key: answer_key,
          question_id: question.id
        })

        answer.update_attribute(:enabled, true)
        answer.update_attribute(:position, position)
        answer.update_attribute(:text, answer_data[:text])

        is_correct = answer_data.has_key?(:is_correct) ? answer_data[:is_correct] : false
        answer.update_attribute(:is_correct, is_correct)
      end
    end
  end
end
