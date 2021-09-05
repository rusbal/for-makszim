def create_users
  User.destroy_all
  15.times { FactoryBot.create(:user) }
  p "Created #{User.count} users."
end

def create_albums_and_photos
  Photo.destroy_all
  Album.destroy_all

  50.times do
    album = FactoryBot.create(:album)
    [1, 2, 3, 4, 5].sample.times do
      FactoryBot.create(:photo, album: album)
    end
  end

  p "Created #{Album.count} albums."
  p "Created #{Photo.count} photos."
end

create_users
create_albums_and_photos
