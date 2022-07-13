import { randInteger } from 'church-jump/utils'
import Actor from 'church-jump/actors/Actor'

export default class Cloud extends Actor {
  constructor(canvasWidth) {
    super()
    this.sprite = 'cloud'
    this.speedMod = randInteger(6, 14) / 10
    // these are dynamically set by the game
    this.speed = null
    this.x = null
    this.y = null
  }

  nextFrame() {
    this.x -= this.speed * this.speedMod
  }
}
