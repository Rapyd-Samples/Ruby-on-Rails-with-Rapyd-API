class CreateProducts < ActiveRecord::Migration[7.0]
  def change
    create_table :products do |t|
      t.string :title
      t.text :description
      t.decimal :amount, precision: 8, scale: 2, default: 0.0

      t.timestamps
    end
  end
end
