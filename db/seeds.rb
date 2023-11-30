# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end
require "json"
require "open-uri"
puts "Destroying all data"

Toss.destroy_all
Item.destroy_all
Place.destroy_all
TrashBin.destroy_all
User.destroy_all
puts "creating users"

# User:
yamada = User.create!(
  email: 'yamada@gmail.com',
  password: '123456',
)
puts "user1 created"


tanaka = User.create!(
  email: 'tanaka@gmail.com',
  password: '123456'
)
puts "user2 created"

suzuki = User.create!(
  email: 'suzuki@gmail.com',
  password: '123456'
)
puts "user3 created"

nagatomo = User.create!(
  email: 'nagatomo@gmail.com',
  password: '123456'
)
puts "user4 created"

# Item:

puts "creating items"

item1 = Item.create!(
  name: "plastic bottle",
  category: "PET bottle",
  volume: 500
)
puts "item1 - plastic bottle 500mL(500cm3) created"

item2 = Item.create!(
  name: "aluminium can",
  category: "can",
  volume: 350
)
puts "item2 - aluminium can 350mL(350cm3) created"

item3 = Item.create!(
  name: "glass drink",
  category: "glass",
  volume: 350
)
puts "item3 - glass drink 350mL(350cm3) created"

item4 = Item.create!(
  name: "magazine",
  category: "paper",
  volume: 800
)
puts "item4 - magazine 800cm3(800ml) created"

item5 = Item.create!(
  name: "plastic food container",
  category: "plastic",
  volume: 700
)
puts "item5 - plastic food container 700ml(700cm3) created"

item6 = Item.create!(
  name: "waster paper",
  category: "burnables",
  volume: 200
)
puts "item6 -burnables waster paper 200cm3 created"

item7 = Item.create!(
  name: "battery",
  category: "non-burnables",
  volume: 100
)
puts "item7 -non-burnables batteries created"


###
puts "creating places"

place1 = Place.create!(
  user: User.all.sample,
  name: "Tokyo Station",
  latitude: 35.68138865387894,
  longitude: 139.76711944161775,
  description: "Near the central entrance of Marunouchi Underground",
)
puts "place1 - Tokyo Station created"
file = URI.open("https://i.ibb.co/T2ywk5P/tokyo.jpg")
place1.photos.attach(io: file, filename: "place1.png", content_type: "image/png")
place1.save
puts "place1 photo uploaded"

bin1 = TrashBin.create!(
  user: User.all.sample,
  category: "paper",
  capacity: 30,
  place: place1,
)
puts "trash_bin1 -paper in place1 - Tokyo Station created"

bin2 = TrashBin.create!(
  user: User.all.sample,
  category: "can",
  capacity: 30,
  place: place1,
)
puts "trash_bin2 -can in place1 - Tokyo Station created"

bin3 = TrashBin.create!(
  user: User.all.sample,
  category: "PET bottle",
  capacity: 30,
  place: place1,
)
puts "trash_bin3 -petbottle in place1 - Tokyo Station created"

bin4 = TrashBin.create!(
  user: User.all.sample,
  category: "plastic",
  capacity: 30,
  place: place1,
)
puts "trash_bin4 -petbottle in place1 - Tokyo Station created"

####
place2 = Place.create!(
  user: User.all.sample,
  name: "Osaki Station",
  latitude: 35.6218522661428,
  longitude: 139.72883214608052,
  description: "In front of the north ticket gate concourse toilet",
)
puts "place2 - Osaki Station Station created"
file = URI.open("https://i.ibb.co/988Vc8n/oosaki.jpg")
place2.photos.attach(io: file, filename: "place2.png", content_type: "image/png")
place2.save
puts "place2 photo uploaded"

bin5 = TrashBin.create!(
  user: User.all.sample,
  category: "paper",
  capacity: 30,
  place: place2,
)
puts "trash_bin5 -paper in place2 - osaki Station created"
bin6 = TrashBin.create!(
  user: User.all.sample,
  category: "can",
  capacity: 30,
  place: place2,
)
puts "trash_bin6 -can in place2 - osaki Station created"
bin7 = TrashBin.create!(
  user: User.all.sample,
  category: "PET bottle",
  capacity: 30,
  place: place2,
)
puts "trash_bin7 -petbottle in place2 - osaki Station created"
bin8 = TrashBin.create!(
  user: User.all.sample,
  category: "plastic",
  capacity: 30,
  place: place2,
)
puts "trash_bin8 -petbottle in place2 - osaki Station created"

place3 = Place.create!(
  user: User.all.sample,
  name: "Meguro JR Station",
  latitude: 35.6340161024763,
  longitude:  139.71554439283088,
  description: "near cart 9-12, near NewDays and the exit to Metro Station in the platform",
)
puts "place3 - meguro Station created"


bin9 = TrashBin.create!(
  user: User.all.sample,
  category: "paper",
  capacity: 30,
  place: place3,
)
puts "trash_bin9 -paper in place3 -  meguro Station created"
bin10 = TrashBin.create!(
  user: User.all.sample,
  category: "can",
  capacity: 30,
  place: place3,
)
puts "trash_bin10 -can in place3 -  meguro Station created"
bin11 = TrashBin.create!(
  user: User.all.sample,
  category: "PET bottle",
  capacity: 30,
  place: place3,
)
puts "trash_bin11 -petbottle in place3 - meguro Station created"

#####

# place4 = Place.create!(
  #user: User.all.sample,
  #name: "Le Wagon Tokyo",
  #latitude: 35.634269435296645,
  #longitude: 139.70811773947588,
  #description: "Vending Machines near Le Wagon",
# )
# puts "place4 - Vending Machines near Le Wagon"
# file = URI.open("https://i.ibb.co/N3315M2/lewagon.jpg")
# place4.photos.attach(io: file, filename: "place4.png", content_type: "image/png")
# place4.save
# puts "place4 photo uploaded"

#bin12 = TrashBin.create!(
  #category: "PET bottle",
  #capacity: 30,
  #place: place4,
#)
#puts "trash_bin12 -petbottle in place4 - lewagon created"

#bin13 = TrashBin.create!(
  #category: "PET bottle",
#   capacity: 30,
#   place: place4,
# )
# puts "trash_bin13 -petbottle in place4 - lewagon created"


place5 = Place.create!(
  user: User.all.sample,
  name: "Omotesando, Harajuku",
  latitude: 35.667572879331345,
  longitude: 139.70773226586482,
  description: "along Omotesando, Harajuku",
)
file = URI.open("https://i.ibb.co/Zc9MbwV/harajuku-jpg.webp")
place5.photos.attach(io: file, filename: "place4.png", content_type: "image/png")
place5.save
puts "place5 photo uploaded"

bin14 = TrashBin.create!(
  user: User.all.sample,
  category: "can",
  capacity: 30,
  place: place5,
)
puts "trash_bin14 -can in place5 - harajuku created"
bin15 = TrashBin.create!(
  user: User.all.sample,
  category: "PET bottle",
  capacity: 30,
  place: place5,
)
puts "trash_bin15 -can in place5 - harajukau created"
bin16 = TrashBin.create!(
  user: User.all.sample,
  category: "glass",
  capacity: 30,
  place: place5,
)
puts "trash_bin15 -can in place5 - harajuka created"

# puts "Toss creating"

# toss1 = Toss.create!(
#   user: yamada,
#   trash_bin: bin1,
#   item: item4
# )

# toss2 = Toss.create!(
#   user: tanaka,
#   trash_bin: bin6,
#   item: item2
# )

# toss3 = Toss.create!(
#   user: suzuki,
#   trash_bin: bin11,
#   item: item1
# )

# toss4 = Toss.create!(
#   user: nagatomo,
#   trash_bin: bin16,
#   item: item3
# )

puts "Seeding with Photos finished"

puts "Now, the real bins -paper"

filepath = File.join(Rails.root,'db','recycling.json')
data = JSON.parse(File.read(filepath))

mapbox_token = "pk.eyJ1Ijoic2dna2R1a2UiLCJhIjoiY2xvNTVpamMxMDZ1bjJ2bng4YTJmeHgxZCJ9.UdCeZ5cXHGpJTyP5XeaPFw"

data["features"].each do |feature|
  next unless feature["properties"]["recycling:paper"]

  longitude = feature["geometry"]["coordinates"][0]
  latitude = feature["geometry"]["coordinates"][1]

  url = "https://api.mapbox.com/geocoding/v5/mapbox.places/#{longitude},#{latitude}.json?access_token=#{mapbox_token}"

  mapbox_response = URI.open(url).read
  mapbox_data = JSON.parse(mapbox_response)

  address = mapbox_data["features"][0]["place_name"]
  name = address.split(", ", 2).first

  newpaperplace = Place.create!(
    user: User.all.sample,
    name: name,
    longitude: longitude,
    latitude:  latitude,
    description: address
  )

  paperbin = TrashBin.create!(
    user: User.all.sample,
    category: "paper",
    place:  newpaperplace
  )

end

puts "Now, the real bins -paper finished"
puts "Now, the real bins -cans"

require "open-uri"

filepath = File.join(Rails.root,'db','recycling.json')
data = JSON.parse(File.read(filepath))

mapbox_token = "pk.eyJ1Ijoic2dna2R1a2UiLCJhIjoiY2xvNTVpamMxMDZ1bjJ2bng4YTJmeHgxZCJ9.UdCeZ5cXHGpJTyP5XeaPFw"

data["features"].each do |feature|
  next unless feature["properties"]["recycling:cans"]

  longitude = feature["geometry"]["coordinates"][0]
  latitude = feature["geometry"]["coordinates"][1]

  url = "https://api.mapbox.com/geocoding/v5/mapbox.places/#{longitude},#{latitude}.json?access_token=#{mapbox_token}"

  mapbox_response = URI.open(url).read
  mapbox_data = JSON.parse(mapbox_response)

  address = mapbox_data["features"][0]["place_name"]
  name = address.split(", ", 2).first

  newcanplace = Place.find_or_create_by(name: name) do |p|
    p.longitude = longitude
    p.latitude =  latitude
    p.description = address
    p.user = User.all.sample
  end

    canbin = TrashBin.create!(
      user: User.all.sample,
     category: "can",
      place:  newcanplace)

end

puts "glass bin now"

filepath = File.join(Rails.root,'db','recycling.json')
data = JSON.parse(File.read(filepath))

mapbox_token = "pk.eyJ1Ijoic2dna2R1a2UiLCJhIjoiY2xvNTVpamMxMDZ1bjJ2bng4YTJmeHgxZCJ9.UdCeZ5cXHGpJTyP5XeaPFw"

data["features"].each do |feature|
  next unless feature["properties"]["recycling:glass_bottles"]

  longitude = feature["geometry"]["coordinates"][0]
  latitude = feature["geometry"]["coordinates"][1]

  url = "https://api.mapbox.com/geocoding/v5/mapbox.places/#{longitude},#{latitude}.json?access_token=#{mapbox_token}"

  mapbox_response = URI.open(url).read
  mapbox_data = JSON.parse(mapbox_response)

  address = mapbox_data["features"][0]["place_name"]
  name = address.split(", ", 2).first

  newglassplace = Place.find_or_create_by(name: name) do |p|
    p.longitude = longitude
    p.latitude =  latitude
    p.description = address
    p.user = User.all.sample
  end

  glassbin = TrashBin.create!(
    user: User.all.sample,
   category: "glass",
  place:  newglassplace
  )
end

puts "plastic bottle bin now"

filepath = File.join(Rails.root,'db','recycling.json')
data = JSON.parse(File.read(filepath))


mapbox_token = "pk.eyJ1Ijoic2dna2R1a2UiLCJhIjoiY2xvNTVpamMxMDZ1bjJ2bng4YTJmeHgxZCJ9.UdCeZ5cXHGpJTyP5XeaPFw"

data["features"].each do |feature|
  next unless feature["properties"]["recycling:plastic_bottles"] ||
             feature["properties"]["recycling:PET"]

  longitude = feature["geometry"]["coordinates"][0]
  latitude = feature["geometry"]["coordinates"][1]

  url = "https://api.mapbox.com/geocoding/v5/mapbox.places/#{longitude},#{latitude}.json?access_token=#{mapbox_token}"

  mapbox_response = URI.open(url).read
  mapbox_data = JSON.parse(mapbox_response)

  address = mapbox_data["features"][0]["place_name"]
  name = address.split(", ", 2).first

  newbottleplace = Place.find_or_create_by(name: name) do |p|
    p.longitude = longitude
    p.latitude =  latitude
    p.description = address
    p.user = User.all.sample
  end

  glassbin = TrashBin.create!(
   category: "PET bottle",
    place:  newbottleplace,
    user: User.all.sample
  )
end


filepath = File.join(Rails.root,'db','recycling.json')
data = JSON.parse(File.read(filepath))


mapbox_token = "pk.eyJ1Ijoic2dna2R1a2UiLCJhIjoiY2xvNTVpamMxMDZ1bjJ2bng4YTJmeHgxZCJ9.UdCeZ5cXHGpJTyP5XeaPFw"

data["features"].each do |feature|
  next unless feature["properties"]["recycling:plastic"] || feature["properties"]["recycling:plastic_packaging"]


  longitude = feature["geometry"]["coordinates"][0]
  latitude = feature["geometry"]["coordinates"][1]

  url = "https://api.mapbox.com/geocoding/v5/mapbox.places/#{longitude},#{latitude}.json?access_token=#{mapbox_token}"

  mapbox_response = URI.open(url).read
  mapbox_data = JSON.parse(mapbox_response)

  address = mapbox_data["features"][0]["place_name"]
  name = address.split(", ", 2).first

  newplasticplace = Place.find_or_create_by(name: name) do |p|
    p.longitude = longitude
    p.latitude =  latitude
    p.description = address
    p.user = User.all.sample
  end

  glassbin = TrashBin.create!(
   category: "plastic",
    place:  newplasticplace,
    user: User.all.sample
  )
end

puts "Now, the real bins seeds finished "

puts "extra bin * 2 for burnables"

newburnableplace1 = Place.find_or_create_by(latitude: 35.60862862905053) do |p|
  p.name = "自由が丘1丁目9-8"
  p.longitude = 139.67420406029152
  p.description = "〒152-0035 東京都目黒区自由が丘１丁目９−８"
  p.user = User.all.sample
end

bin20 = TrashBin.create!(
  user: User.all.sample,
  category: "burnables",
  capacity: 30,
  place: newburnableplace1,
)

newburnableplace2 = Place.find_or_create_by(latitude: 35.62073772791616) do |p|
  p.name = "武蔵小山駅ビル"
  p.longitude = 139.70446838384493
  p.description = "〒142-0062 東京都品川区小山３丁目４−８ 武蔵小山駅ビル"
  p.user = User.all.sample
end

bin21 = TrashBin.create!(
  user: User.all.sample,
  category: "burnables",
  capacity: 30,
  place: newburnableplace2,
)

puts "extra bin * 2 for inburnables"

newinburnableplace1 = Place.find_or_create_by(latitude: 35.66548689285389) do |p|
  p.name = "渋谷区神宮前6丁目17"
  p.longitude = 139.703164017791
  p.description = "〒150-0001 東京都渋谷区神宮前6丁目17"
  p.user = User.all.sample
end

newinburnableplace2 = Place.find_or_create_by(latitude: 35.66707630082036) do |p|
  p.name = "港区赤坂1丁目12-32"
  p.longitude = 139.73973927116407
  p.description = "〒107-6090 東京都港区赤坂1丁目12-32 アーク森ビル"
  p.user = User.all.sample
end

bin30 = TrashBin.create!(
  user: User.all.sample,
  category: "non-burnables",
  capacity: 30,
  place: newinburnableplace1,
)

bin31 = TrashBin.create!(
  user: User.all.sample,
  category: "non-burnables",
  capacity: 30,
  place: newinburnableplace2,
)
