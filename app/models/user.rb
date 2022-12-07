class User < ApplicationRecord
    validates :username , presence: true , length: {minimum: 3 , maximum:20} , uniqueness: true
    VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
    validates :email , presence: true , uniqueness: true , format: {with: VALID_EMAIL_REGEX}
end