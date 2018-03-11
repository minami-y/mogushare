module UsersHelper
  def mypage_profile_image(user)
    if user.seller.present? && user.seller.photo.present?
      image_tag user.seller.photo, class: "user-image"
    else
      image_tag "blank.jpg", class: "user-image"
    end
  end
end
