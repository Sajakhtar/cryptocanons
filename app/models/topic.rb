class Topic < ApplicationRecord
  has_many :favorite_topics
  CRYPTO = ['nft', 'bitcoin', 'defi']
  validates :title, presence: true, inclusion: { in: CRYPTO }


end
