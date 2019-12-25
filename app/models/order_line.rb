class OrderLine < ApplicationRecord
    belongs_to :order
    belongs_to :menu_item
    after_create  :update_order

    def update_order
        price = self.price + order.total_price
        order.update(total_price: price)
    end
end
