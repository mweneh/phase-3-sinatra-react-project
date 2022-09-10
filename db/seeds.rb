puts "🌱 Seeding spices..."

20.times do
    User.create(name: Faker::Name.name)
end
# require 'uri'
# require 'net/http'
# require 'openssl'

# url = URI("https://free-to-play-games-database.p.rapidapi.com/api/games?platform=pc")

# http = Net::HTTP.new(url.host, url.port)
# http.use_ssl = true
# http.verify_mode = OpenSSL::SSL::VERIFY_NONE

# request = Net::HTTP::Get.new(url)
# request["X-RapidAPI-Key"] = 'eea70ef8f4msh07aa30142c95914p160556jsnc9e4fe0fe637'
# request["X-RapidAPI-Host"] = 'free-to-play-games-database.p.rapidapi.com'

# response = http.request(request)
# puts response.read_body

response = RestClient.get('https://www.freetogame.com/api/games?platform=pc')

   games = JSON.parse(response)
games.each do |game|
    new_game = Game.create(
         title: game['title'],
         thumbnail: game['thumbnail'], 
         short_description:game['short_description'],
         game_url:game['game_url'],
         platform:game['platform'],
         publisher: game['publisher'],
         genre: game['genre'],
         price: rand(10..70)
         
     )
 
 # create between 1 and 5 reviews for each game
 rand(1..5).times do
#     # get a random user for every rating
    user = User.order('RANDOM()').first

    Rating.create(
        rating: rand(1..10),
        comment: Faker::Lorem.sentence,
        game_id: new_game.id,
        user_id: user.id
      )
  end
end
puts "✅ Done seeding!"
