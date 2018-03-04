class AddLocationToAreas < ActiveRecord::Migration[5.0]
  def self.up
    add_column :areas, :lat, :decimal, precision: 9, scale: 6
    add_column :areas, :lng, :decimal, precision: 9, scale: 6
  end

  def self.down
    remove_column :areas, :lat
    remove_column :areas, :lng
  end
end
