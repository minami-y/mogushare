class CreateTalks < ActiveRecord::Migration[5.0]
  def change
    create_table :talks do |t|
      t.text :message, null: false
      t.references :user, null: false
      t.references :group, null: false

      t.timestamps
    end
  end
end
