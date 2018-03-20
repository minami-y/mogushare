class CreateUserPoints < ActiveRecord::Migration[5.0]
  def change
    create_table :user_points do |t|
      t.references :user, foreign_key: true, null: false
      t.integer :amount, null: false, default: 0
    end
  end
end
