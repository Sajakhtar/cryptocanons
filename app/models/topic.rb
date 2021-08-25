class Topic < ApplicationRecord
  has_many :favorite_topics

  validates :title, presence: true
  validates :icon_url, presence: true
end
