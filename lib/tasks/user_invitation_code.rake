namespace :users do
  desc 'create invitation_code'
  task create_invitation_code: :environment do
    User.left_outer_joins(:user_invitation_code).where(user_invitation_codes: {user_id: nil}).each do |user|
      user.create_user_invitation_code!
    end
  end
end
