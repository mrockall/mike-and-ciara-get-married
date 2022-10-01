# encoding: utf-8
# 
# Used to import the content for the games from a yaml file
# 
module Import
  class FromYaml
    def initialize
      config_path = File.join(Rails.root, "config", "games.yml")
      @config = YAML.load(File.read(config_path)).deep_symbolize_keys
    end

    def execute
      # By setting all games to be disabled, we can let the config 
      # enable them. This will allow us to change the config, remove
      # a game, and not have it appear again. This means that the 
      # yaml config is the defacto representation of the enabled games.
      Game.update_all(enabled: false)

      @config.each do |game_key, game_data|
        game = Game.find_or_create_by({
          name: game_data[:name]
        })

        game.update_attribute(:enabled, game_data[:enabled])
      end
    end

    private

  end
end
