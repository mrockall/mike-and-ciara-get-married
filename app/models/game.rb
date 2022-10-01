class Game < ApplicationRecord
  has_many :questions
  
  def url
    "/games/#{self.key}"
  end
end
