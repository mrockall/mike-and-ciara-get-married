class Game < ApplicationRecord

  FORMAT = {
    quiz: 'quiz'
  }

  has_many :questions

  def url
    "/games/#{self.key}"
  end
end
