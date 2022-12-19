module ApplicationHelper
    require "mini_magick"


    def avatar_url_for(user, size)

    

    if user.avatar.attached?
      user.avatar.variant(
        resize_to_limit:[size, size]
      )
    else
      hash = Digest::MD5.hexdigest(user.email.downcase)
      "https://secure.gravatar.com/avatar/#{hash}.png?s=#{32}"
    end
 end

end
