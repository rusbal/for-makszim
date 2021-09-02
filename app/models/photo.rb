class Photo < ApplicationRecord
  belongs_to :album

  validates :name, presence: true
end
