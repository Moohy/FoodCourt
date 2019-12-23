class Restaurant < ApplicationRecord
    belongs_to :user
    has_many :menu_items
    has_many :branches
    accepts_nested_attributes_for :branches, reject_if: :all_blank, allow_destroy: true
end
