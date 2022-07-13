// Configure your import map in config/importmap.rb. Read more: https://github.com/rails/importmap-rails
import "@hotwired/turbo-rails"
import "controllers"
import ChurchJumpGame from 'church-jump/index.js'

const church_game = document.getElementById('church-game')
if(church_game)
  ChurchJumpGame();
