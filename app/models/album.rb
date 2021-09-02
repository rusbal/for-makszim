class Album < ApplicationRecord
  has_many :photos, dependent: :destroy

  validates :name, presence: true
end
