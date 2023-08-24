class User < ApplicationRecord
  validates :username, presence: true, length: {minimum: 10, maximum:100}
  validates :email, presence: true
end
