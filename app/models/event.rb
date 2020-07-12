class Event < ApplicationRecord
    belongs_to :owner, class_name: 'User'
    has_many :users_going_to_events, dependent: :destroy
    has_many :users, through: :users_going_to_events
    validates :title, :description, :when, presence: true\

    # this should be a query but it dosnt like it
    def Event.present
        Event.all.filter { |event| event.when.to_datetime >= DateTime.now}
    end

    def Event.past
        Event.all.filter { |event| event.when.to_datetime <= DateTime.now}
    end
end
