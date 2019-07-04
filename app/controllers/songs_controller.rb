require 'pry'
require 'rack-flash'
class SongsController < ApplicationController
  enable :sessions
  use Rack::Flash

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

  patch '/songs/:slug' do

    @song = Song.find_by_slug(params[:slug])
    @song.name = params[:song][:name]
    @song.artist.name = params[:artist][:name]
    genres = params[:genre][:name].map do |genre|
      Genre.find_by(:name => genre)
    end
    @song.genres = genres
    @song.save
    @song.artist.save
    flash[:message]= "Successfully updated song."
    redirect "/songs/#{@song.slug}"
  end

  get '/songs/:slug/edit' do
    @song = Song.find_by_slug(params[:slug])
    @genres = Genre.all
    erb :'/songs/edit'
  end

end
