require "sinatra"
require "sinatra/reloader"
require "httparty"
def view(template); erb template.to_sym; end

get "/" do
  ### Get the weather
  # Evanston, Kellogg Global Hub... replace with a different location if you want
  lat = 42.0574063
  long = -87.6722787

  units = "imperial" # or metric, whatever you like
  key = "eae067a11018332286c1cae364b5756e" # replace this with your real OpenWeather API key

  # construct the URL to get the API data (https://openweathermap.org/api/one-call-api)
  url = "https://api.openweathermap.org/data/2.5/onecall?lat=42.0574063&lon=-87.6722787&units=imperial&appid=eae067a11018332286c1cae364b5756e"

  # make the call
  @forecast = HTTParty.get(url).parsed_response.to_hash
  
  ### Get the news
    # do everything else
    view "weather"
end

get "/news" do
url = "https://newsapi.org/v2/top-headlines?country=us&apiKey=f6dfd183082d4ec6b2e4181882398a51"
@news = HTTParty.get(url).parsed_response.to_hash
# news is now a Hash you can pretty print (pp) and parse for your output
 view "news"
end