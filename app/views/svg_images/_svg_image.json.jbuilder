json.extract! svg_image, :id, :data, :name, :source, :created_at, :updated_at
json.url svg_image_url(svg_image, format: :json)