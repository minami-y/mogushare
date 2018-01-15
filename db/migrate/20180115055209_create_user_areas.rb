class CreateUserAreas < ActiveRecord::Migration[5.0]
  def change
    create_table :user_areas do |t|
      t.integer :user_id
      t.integer :area_id

      t.timestamps
    end
  end
end
