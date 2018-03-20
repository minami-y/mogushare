class AddUserInvitationColumn < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :use_invitation_code, :boolean, null: false, default: false
  end
end
