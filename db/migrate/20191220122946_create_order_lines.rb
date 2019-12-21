class CreateOrderLines < ActiveRecord::Migration[6.0]
  def change
    create_table :order_lines do |t|
      t.references :menu_item
      t.references :order
      t.decimal :price
      t.integer :quantity

      t.timestamps
    end
  end
end
