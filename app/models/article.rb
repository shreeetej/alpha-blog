class Article < ApplicationRecord
  belongs_to :user

  validates :title, presence: true, length: {minimum:10, maximum:100}
  validates :description, presence: true, length: {minimum:10, maximum:1000}

  paginates_per 10
end
