class Event < ApplicationRecord
    belongs_to :owner, class_name: 'User'
    has_many :users_going_to_events, dependent: :destroy
    has_many :users, through: :users_going_to_events
    validates :title, :description, :when, presence: true

    scope :present, -> { where("when >= ?", DateTime.now) }
end
