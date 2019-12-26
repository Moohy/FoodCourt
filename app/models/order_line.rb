class OrderLine < ApplicationRecord
    belongs_to :order
    belongs_to :menu_item
    after_create  :update_order
    before_destroy :decrease_price

    private
        def update_order
            price = self.price + order.total_price
            order.update(total_price: price)
        end
        
        def decrease_price
            price = order.total_price - self.price 
            order.update(total_price: price)
        end
end
