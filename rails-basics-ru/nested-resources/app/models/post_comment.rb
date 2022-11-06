class PostComment < ApplicationRecord
  belongs_to :post

  validates :body, presence: true
  validates :body, length: { maximum: 500 }
end
