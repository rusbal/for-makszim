json.array! @albums do |album|
  json.id album.id
  json.name album.name
  json.created_at album.created_at
  json.updated_at album.updated_at

  json.photos do
    json.array! album.photos do |photo|
      json.id photo.id
      json.name photo.name
      json.created_at photo.created_at
      json.updated_at photo.updated_at
    end
  end
end
