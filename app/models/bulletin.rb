# frozen_string_literal: true

class Bulletin < ApplicationRecord
  include AASM

  belongs_to :user
  belongs_to :category
  validates :image, file_size: { less_than_or_equal_to: 5.megabytes },
                    file_content_type: { allow: ['image/jpeg', 'image/png'] }
  has_one_attached :image

  aasm column: 'state' do
    state :draft, initial: true
    state :under_moderation
    state :published
    state :rejected
    state :archived

    # event :publish do
    #   transitions from: :under_moderation, to: :published
    # end

    # event :archive do
    #   transitions from: [:published, :under_moderation], to: :archived
    # end
  end
end
