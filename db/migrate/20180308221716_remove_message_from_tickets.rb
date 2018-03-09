class RemoveMessageFromTickets < ActiveRecord::Migration[5.0]
  def change
    remove_column :tickets, :message
  end
end
