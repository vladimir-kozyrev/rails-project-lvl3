class Bulletin < ApplicationRecord
  belongs_to :user
  belongs_to :category
  validates :image, file_size: { less_than_or_equal_to: 5.megabytes },
                    file_content_type: { allow: ['image/jpeg', 'image/png'] }
  has_one_attached :image
end
