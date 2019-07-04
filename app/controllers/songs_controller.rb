require 'pry'
class SongsController < ApplicationController
  register Rack::Flash

  get '/songs' do
    @songs = Song.all
    erb :'songs/index'
  end

  get '/songs/new' do
    @genres = Genre.all
    erb :'/songs/new'
  end

  post '/songs' do
    @song = Song.create(params[:song])
    artist = Artist.find_or_create_by(params[:artist])
    @song.artist = artist
    genres = []
    params[:genres][:names].each do |genre|
      genres << Genre.find_by(:name => genre)
    end
    @song.genres = genres
    @song.save
    flash[:message] = "Successfully created song."
    redirect to ("/songs/#{@song.slug}")
  end

  get '/songs/:slug' do
    @song = Song.find_by_slug(params[:slug])
    erb :'songs/show'
  end

  get '/songs/:slug/edit' do
    @song = Song.find_by_slug(params[:slug])
    erb :'/songs/edit'
  end

end
