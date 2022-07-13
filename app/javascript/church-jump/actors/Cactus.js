import { randItem } from 'church-jump/utils'
import Actor from 'church-jump/actors/Actor'

const VARIANTS = ['cactus', 'cactusDouble', 'cactusDoubleB', 'cactusTriple']

export default class Cactus extends Actor {
  constructor(imageData) {
    super(imageData)
    this.sprite = randItem(VARIANTS)
    // these are dynamically set by the game
    this.speed = null
    this.x = null
    this.y = null
  }

  nextFrame() {
    this.x -= this.speed
  }
}
