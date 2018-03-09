class RemoveImageFromTickets < ActiveRecord::Migration[5.0]
  def change
    remove_column :tickets, :image
  end
end
