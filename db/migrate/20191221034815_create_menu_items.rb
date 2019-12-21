class CreateMenuItems < ActiveRecord::Migration[6.0]
  def change
    create_table :menu_items do |t|
      t.references :restaurant
      t.string :name
      t.string :ar_name
      t.text :description
      t.decimal :price
      t.integer :quantity


      t.timestamps
    end
  end
end
