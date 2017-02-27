class CreateOwnerReviews < ActiveRecord::Migration[5.0]
  def change
    create_table :owner_reviews do |t|
      t.integer :rating
      t.text :comment
      t.string :state
      t.references :profile, foreign_key: true
      t.references :order, foreign_key: true

      t.timestamps
    end
  end
end
