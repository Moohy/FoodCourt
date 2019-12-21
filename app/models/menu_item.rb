class MenuItem < ApplicationRecord
    belongs_to :restaurant
    has_many :order_lines
    has_many :orders, through: :order_lines
end
