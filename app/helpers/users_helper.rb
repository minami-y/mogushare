module UsersHelper
  def mypage_profile_image(user)
    if user.image.present?
      image_tag user.image, class: "user-image"
    else
      image_tag "", class: "user-image"
    end
  end
end
