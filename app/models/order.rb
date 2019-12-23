class Order < ApplicationRecord
    belongs_to :user
    belongs_to :branch
    has_many :order_lines
    has_many :menu_items, through: :order_lines
    accepts_nested_attributes_for :order_lines, reject_if: :all_blank, allow_destroy: true
end
