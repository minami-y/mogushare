class CreateTickets < ActiveRecord::Migration[5.0]
  def change
    create_table :tickets do |t|
      t.text :message, null: false
      t.datetime :event_date, null: false
      t.datetime :expiration_date, null: false
      t.string :event_place, null: false
      t.references :seller
      t.references :buyer

      t.timestamps
    end
  end
end
