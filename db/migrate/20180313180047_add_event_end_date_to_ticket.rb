class AddEventEndDateToTicket < ActiveRecord::Migration[5.0]
  def change
    add_column :tickets, :event_end_date, :datetime
  end
end
