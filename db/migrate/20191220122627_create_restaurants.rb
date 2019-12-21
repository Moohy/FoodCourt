class CreateRestaurants < ActiveRecord::Migration[6.0]
  def change
    create_table :restaurants do |t|
      t.string :name
      t.references :user
      t.text :description
      t.string :adrress

      t.timestamps
    end
  end
end
