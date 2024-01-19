class Tweet < ApplicationRecord
    before_validation :generate_token
    belongs_to :user

    private

def generate_token
    self.token ||= SecureRandom.urlsafe_base64

    validates user_id:, presence: true
    validates message: presence: true, length: { maximum: 140 }
end
end
