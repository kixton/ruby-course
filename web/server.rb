require_relative '../lib/songify.rb'
require 'sinatra/base'

module Songify
  def self.populate_database
    Songify::Repos.drop_tables
    Songify::Repos.create_tables

    song1 = Songify::Song.new("Dark Horse", "Katy Perry", "Prism")
    song2 = Songify::Song.new("Cry Me A River", "Justin Timberlake", "Justified")
    song3 = Songify::Song.new("Crazy In Love", "Beyonce", "Dangerously In Love")

    Songify.songsrepo.add(song1)
    Songify.songsrepo.add(song2)
    Songify.songsrepo.add(song3)
  end
end

class Songify::Server < Sinatra::Application

  get '/songs' do
    @songs = Songify.songsrepo.get_all
    erb :allsongs
  end

  get '/songs/new' do
    erb :newsong
  end

  get '/songs/:id' do
    @song = Songify.songsrepo.get(params[:id])
    erb :singlesong
  end

  post '/songs' do
    song = Songify::Song.new(params["song_name"], params["artist"], params["album"])
    Songify.songsrepo.add(song)
    redirect to("/songs/#{song.song_id}")
  end 

  post '/songs/:id/edit' do
    @song = Songify.songsrepo.get(params[:id])
    erb :editsong
  end  

end

