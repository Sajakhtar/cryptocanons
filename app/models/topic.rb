class Topic < ApplicationRecord
  has_many :favorite_topics
  has_many :bookmarked_articles

  validates :title, presence: true
  validates :icon_url, presence: true
end
