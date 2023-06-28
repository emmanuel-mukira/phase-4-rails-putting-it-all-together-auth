class User < ApplicationRecord
    validates :username, uniqueness: true , presence: true
    has_secure_password 
    has_many :recipes 
    
end
