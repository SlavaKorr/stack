class AddSubscription < ActiveRecord::Migration
  def change
    create_table :subscriptions do |t|
      t.references :user
      t.references :question
      t.index [:user_id, :question_id], unique: true
      t.timestamps null: false
    end
  end
end
