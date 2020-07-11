class User < ApplicationRecord
    validates :email, :name, presence: true
    validates :email, uniqueness: true

    def login(session)
        session[:user_id] = self.id
    end

    def logout(session)
        p session.delete(:user_id)
    end
end
