class CreateOrders < ActiveRecord::Migration[5.0]
  def change
    create_table :orders do |t|
      t.date :start_date
      t.date :end_date
      t.integer :days
      t.string :status
      t.float :total_price
      t.references :game, foreign_key: true
      t.references :profile, foreign_key: true

      t.timestamps
    end
  end
end
