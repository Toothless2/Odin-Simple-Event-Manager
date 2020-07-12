class User < ApplicationRecord
    validates :email, :name, presence: true
    validates :email, uniqueness: true

    has_many :users_going_to_events, dependent: :destroy
    has_many :events, through: :users_going_to_events
    
    has_many :created_events, foreign_key: 'owner_id', class_name: 'Event', dependent: :destroy

    def login(session)
        session[:user_id] = self.id
    end

    def logout(session)
        session.delete(:user_id)
    end

    def previousEvents
        self.events.all.filter { |event| event.when.to_datetime <= DateTime.now}
    end

    def currentEvents
        self.events.all.filter { |event| event.when.to_datetime >= DateTime.now}
    end
end
