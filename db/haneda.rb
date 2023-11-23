require "json"
require "open-uri"

filepath = 'haneda.json'
platform_data = File.read(filepath)
data = JSON.parse(platform_data)
# Extract all locations
locations = []
data["features"].each do |feature|
  locations << {
    lon: feature["geometry"]["coordinates"][0],
    lat: feature["geometry"]["coordinates"][1]
  }
end

# Build one API request
mapbox_token ="pk.eyJ1Ijoic2dna2R1a2UiLCJhIjoiY2xvNTVpamMxMDZ1bjJ2bng4YTJmeHgxZCJ9.UdCeZ5cXHGpJTyP5XeaPFw"

data["features"].each do |feature|
  name = feature["properties"]["name"]
  next if name.nil?

  longitude = feature["geometry"]["coordinates"][0]
  latitude = feature["geometry"]["coordinates"][1]

  url = "https://api.mapbox.com/geocoding/v5/mapbox.places/#{longitude},#{latitude}.json?access_token=#{mapbox_token}"
  mapbox_response = URI.open(url).read
  mapbox_data = JSON.parse(mapbox_response)
  address = mapbox_data["features"][0]["place_name"]
  spot_name = address.split(", ", 2).first

  puts "Name: #{spot_name}"
  puts "Longitude: #{longitude}"
  puts "Latitude: #{latitude}"
  puts "Description: #{address}"

end
