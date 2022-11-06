# frozen_string_literal: true

class Post < ApplicationRecord
  # BEGIN
  has_many :comments, class_name: 'PostComment', foreign_key: 'post_id', dependent: :destroy
  # END

  validates :title, presence: true
  validates :body, length: { maximum: 500 }
end
