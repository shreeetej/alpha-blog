class User < ApplicationRecord

  validates :username, presence: true,
  uniqueness: {case_sensitive: false},
  length: {minimum: 3, maximum:25}

  VALID_EMAIL_REGEX = /\A([\w+\-].?)+@[a-z\d\-]+(\.[a-z]+)*\.[a-z]+\z/i

  validates :email, presence: true,
                    uniqueness: {case_sensitive: false}, # nothing just moved to new line for better view,
                    format: {with: VALID_EMAIL_REGEX},
                    length: {maximum:105}
end
