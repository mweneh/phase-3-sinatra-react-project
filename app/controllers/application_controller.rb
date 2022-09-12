require 'pry'

class ApplicationController < Sinatra::Base
  set :default_content_type, 'application/json'

  get '/games/all' do
    games = Game.all
    games.to_json
  end

  get '/games/all/fav' do
    games = Game.all.order(:price).limit(20)
    games.to_json
  end

  get '/users/all'  do
    users = User.all.limit(10)
    users.to_json(only:[:name,:id])
  end


  get '/ratings/all' do
    ratings = Rating.all.limit(20)
    ratings.to_json
  end

  get '/games/:id' do
    game = Game.find(params[:id])

    game.to_json( include: {
      ratings: { only: [:comment, :rating], include: {
        user: { only: [:name] }
      } }
    })
  end

  get '/users/:id' do
    user = User.find(params[:id])
    user.to_json(only:[:name,:id])
  end

  delete '/comment/:id' do
    comment = Review.find(params[:id])
    comment.destroy
    comment.to_json
  end

  delete '/users/:id' do
    user = User.find(params[:id])
   user.destroy
    user.to_json
  end

  post '/users/add' do
    user = User.create(
      name: params[:name]
    )
    user.to_json
  end

  post '/ratings/add' do
    rating = Rating.create(
      rating: params[:rating],
      comment: params[:comment],
      game_id: params[:game_id],
      user_id: params[:user_id]
    )
    rating.to_json
  end

  patch '/ratings/edit/:id' do
    rating = Rating.find(params[:id])
    rating.update(
      rating: params[:rating],
      comment: params[:comment]
    )
    rating.to_json
  
  end

  put '/ratings/put/:id' do
    rating = Rating.find(params[:id])
    rating.update(
      rating: params[:rating],
      comment: params[:comment],
      game_id: params[:game_id],
      user_id: params[:user_id]
    )
    rating.to_json
  end

  put '/users/put/:id' do
    user = User.find(params[:id])
      user.update(
        name: params[:name]
    )
    user.to_json
  end
end
