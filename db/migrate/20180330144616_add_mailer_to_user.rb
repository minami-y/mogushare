class AddMailerToUser < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :mailer, :boolean, default: true, null: false
  end
end
