module ImageHelper


def link_to_image(image_path, target_link,options={})
  link_to(image_tag(image_path, :border => "0",size: "25x25", alt:"WDS"), target_link, options)
end

end
