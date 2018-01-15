class CreatePrefecturals < ActiveRecord::Migration[5.0]
  def change
    create_table :prefecturals do |t|
      t.string :name

      t.timestamps
    end
  end
end
