require "json"
require "open-uri"

filepath = 'recycling.json'
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

  puts "Name: #{name}"
  puts "Longitude: #{longitude}"
  puts "Latitude: #{latitude}"
  puts "Address: #{address}"

end
