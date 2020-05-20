require "sinatra"
require "sinatra/reloader"
require "httparty"
def view(template); erb template.to_sym; end

get "/" do
  ### Get the weather
  # Evanston, Kellogg Global Hub... replace with a different location if you want
  lat = 42.0574063
  long = -87.6722787

  units = "imperial"
  openweather_key = "eae067a11018332286c1cae364b5756e"

  # construct the URL to get the API data (https://openweathermap.org/api/one-call-api)
  url = "https://api.openweathermap.org/data/2.5/onecall?lat=42.0574063&lon=-87.6722787&units=imperial&appid=eae067a11018332286c1cae364b5756e"
  @forecast = HTTParty.get(url).parsed_response.to_hash
    
    @current = ["Temperature: #{@forecast["current"]["temp"]} degrees", "Conditions: #{@forecast["current"]["weather"][0]["description"]}"]
    puts @current
    puts "Weekly Forecast:"
    extended = []
    day_number = 1
    for day in @forecast["daily"]
        extended << "#{day_number} Day: #{day["weather"][0]["description"]} with a Max temperature of #{day["temp"]["max"]} F and a Min temperature of #{day["temp"]["min"]} F"
        day_number = day_number + 1

    end

    @weekly = extended[0, 7]


  ### Get the news

  news_key = "f6dfd183082d4ec6b2e4181882398a51"

  url = "https://newsapi.org/v2/top-headlines?country=us&apiKey=f6dfd183082d4ec6b2e4181882398a51"

  @news = HTTParty.get(url).parsed_response.to_hash

    stories = []
    article_number = 1
    for article in @news["articles"]
        stories << "#{article["url"]}>#{article_number}: #{article["title"]}" 
        article_number = article_number + 1
        
    end

    @topstories = stories[0,5]

    view "news"
end