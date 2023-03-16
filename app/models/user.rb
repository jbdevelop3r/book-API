class User < ApplicationRecord
    has_one :api_key

    validates :clientName, uniqueness: true, presence: true, length: {minimum:3}
    validates :clientEmail, uniqueness: true, presence: true
end
