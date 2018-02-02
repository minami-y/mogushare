class RemoveNullRestrictionFromTalk < ActiveRecord::Migration[5.0]
  def change
    change_column_null :talks, :user_id, true
    change_column_null :talks, :group_id, true
  end
end
