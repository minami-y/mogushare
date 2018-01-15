class CreateAreas < ActiveRecord::Migration[5.0]
  def change
    create_table :areas do |t|
      t.string :postal_code,     null: false, index: true
      t.references :prefectural, index: true
      t.string :city,            default: ""
      t.string :street,          default: ""

      t.timestamps
    end
  end
end
