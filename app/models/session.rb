class Session < ApplicationRecord

    before_validation :generate_token 

    belongs_to :user, required: true

    private

    def generate_token
        self.token ||= SecureRandom.urlsafe_base64 


    validates user_id: presence: true
    end
    
end
