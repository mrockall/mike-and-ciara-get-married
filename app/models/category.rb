class Category < ApplicationRecord

  has_many :questions, dependent: :destroy

  validates_presence_of :title

end
