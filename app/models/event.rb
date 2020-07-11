class Event < ApplicationRecord
    belongs_to :owner, class_name: 'User'
    validates :title, :description, :when, presence: true
end
