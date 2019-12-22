class CreateBranches < ActiveRecord::Migration[6.0]
  def change
    create_table :branches do |t|
      t.references :restaurant, null: false, foreign_key: true
      t.string :city
      t.string :address

      t.timestamps
    end
  end
end
