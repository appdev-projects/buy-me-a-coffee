class CreateSubscriptions < ActiveRecord::Migration[7.0]
  def change
    create_table :subscriptions do |t|
      t.string :stripe_subscription_id
      t.integer :price
      t.references :user, null: false, foreign_key: true
      t.string :status
      t.datetime :canceled_at

      t.timestamps
    end
  end
end
