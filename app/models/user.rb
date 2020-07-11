class User < ApplicationRecord
    validates :email, :name, presence: true
    validates :email, uniqueness: true
    
    has_many :created_events, foreign_key: 'owner_id', class_name: 'Event', dependent: :destroy

    def login(session)
        session[:user_id] = self.id
    end

    def logout(session)
        session.delete(:user_id)
    end
end
