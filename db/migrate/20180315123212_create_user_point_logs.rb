class CreateUserPointLogs < ActiveRecord::Migration[5.0]
  def change
    create_table :user_point_logs do |t|
      t.references :user, foreign_key: true, null: false
      t.integer :amount, null: false
      t.integer :reason_id, null: false
      t.text :detail

      t.timestamps
    end
  end
end
