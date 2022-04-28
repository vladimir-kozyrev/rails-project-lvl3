# frozen_string_literal: true

class Bulletin < ApplicationRecord
  include AASM

  belongs_to :user
  belongs_to :category

  validates :title, presence: true
  validates :description, presence: true
  validates :image, presence: true,
                    file_size: { less_than_or_equal_to: 5.megabytes },
                    file_content_type: { allow: ['image/jpeg', 'image/png'] }
  has_one_attached :image

  aasm column: 'state' do
    state :draft, initial: true
    state :under_moderation
    state :published
    state :rejected
    state :archived

    event :to_moderate do
      transitions from: :draft, to: :under_moderation
    end

    event :publish do
      transitions from: :under_moderation, to: :published
    end

    event :reject do
      transitions from: :under_moderation, to: :rejected
    end

    event :archive do
      transitions to: :archived
    end
  end
end
