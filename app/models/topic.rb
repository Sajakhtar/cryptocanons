class Topic < ApplicationRecord
  has_many :favorite_topics
  validates :title, presence: true
end
