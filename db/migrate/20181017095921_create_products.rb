class CreateProducts < ActiveRecord::Migration[5.1]
  def change
    create_table :products do |t|
      t.string :name
      t.string :url
      t.string :barcode
      t.integer :price
      t.string :sku
      t.string :producer

      t.timestamps
    end

    add_index :products, :sku, unique: true
    add_index :products, :producer
  end
end
