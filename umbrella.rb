# Write your soltuion here!
require "dotenv/load"
require "http"
require "json"

#Ask user for location

pp "Which location's weather are you interested in?"

#Get and store user location
user_location = gets.chomp

pp "Checking the forecast in #{user_location}..."

#get the user's lat and long from GMAPS API

maps_url = "https://maps.googleapis.com/maps/api/geocode/json?address=#{user_location}&key=" + ENV.fetch("GMAPS_KEY")

gm_first_response = HTTP.get(maps_url)

gm_response = gm_first_response.to_s

gm_parsed_response = JSON.parse(gm_response)

gm_results = gm_parsed_response.fetch("results")

initial_result = gm_results.at(0)

geometry = initial_result.fetch("geometry")

location = geometry.fetch("location")

latitude = location.fetch("lat")

longitude = location.fetch("lng")

#Get the weather at the user's coordinates from PW API

pw_url = "https://api.pirateweather.net/forecast/" + ENV.fetch("PW_KEY") + "/#{latitude},#{longitude}"

#Display current temperature of the weather for the next hour

pw_first_response = HTTP.get(pw_url)

pw_response = pw_first_response.to_s

pw_parsed_response = JSON.parse(pw_response)

currently = pw_parsed_response.fetch("currently")

current_temp = currently.fetch("temperature")

current_summary = currently.fetch("summary")

puts "It is currently #{current_temp}F and the conditions are #{current_summary}!"


#For each of the next 12 hours check if the precipitation probability is greater than 10%
  #If so print a message saying how many hors from now and what the probability is
# if any of the next 12 hours has a precipitation probability greater than 10% print "you might wnat to bring an umbrella" if not print the opposite
