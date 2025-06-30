module ApplicationHelper
  def user_avatar(user, size: 40)
    if user&.avatar&.attached?
      image_tag url_for(user.avatar), class: "rounded-circle", style: "width: #{size}px; height: #{size}px; object-fit: cover;", alt: "avatar"
    else
      content_tag(:span, '', class: "bi bi-person-circle rounded-circle", style: "font-size: #{size}px; color: #ccc; display: inline-block; width: #{size}px; height: #{size}px;")
    end
  end
end
