class AddColumnToTicketss < ActiveRecord::Migration[5.0]
  def change
    add_column :tickets, :genre, :string
  end
end
