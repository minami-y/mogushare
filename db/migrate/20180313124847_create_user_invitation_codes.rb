class CreateUserInvitationCodes < ActiveRecord::Migration[5.0]
  def change
    create_table :user_invitation_codes do |t|
      t.references :user, foreign_key: true, null: false
      t.string :code, null: false

      t.timestamps
    end

    add_index :user_invitation_codes, :code, unique: true
  end
end
