class CreateSellers < ActiveRecord::Migration[5.0]
  def change
    create_table :sellers do |t|
      t.references :user
      t.string :official_name, null: false
      t.string :address, null: false
      t.string :phone_number, null: false

      t.timestamps
    end
  end
end
