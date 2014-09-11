require_relative '../lib/songify.rb'
require 'sinatra/base'
# require 'pry-byebug'

class Songify::Server < Sinatra::Application

  get '/songs' do # returns list of ALL songs
    @songs = Songify.songsrepo.get_all
    erb :allsongs
  end

  get '/songs/new' do # form to create new song
    erb :newsong
  end

  get '/songs/:id' do # return list of 1 song
    @song = Songify.songsrepo.get(params[:id])
    erb :singlesong
  end

  post '/songs' do # processes new song form
    song = Songify::Song.new(params[:song_name], params[:artist], params[:album], params[:genre_id])
    Songify.songsrepo.add(song)
    redirect to("/songs/#{song.song_id}")
  end 

  get '/songs/:id/edit' do
    @song = Songify.songsrepo.get(params[:id])
    erb :editsong
  end  

  put '/songs/:id' do
    @song = Songify.songsrepo.edit(params[:id], params[:song_name], params[:artist], params[:album], params[:genre_id])
    redirect to("/songs/#{@song.song_id}")
  end

end

