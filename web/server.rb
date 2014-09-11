require_relative '../lib/songify.rb'
require 'sinatra/base'
# require 'pry-byebug'

class Songify::Server < Sinatra::Application

  # returns list of ALL songs
  get '/songs' do 
    @songs = Songify.songsrepo.get_all
    @all_genres = Songify.genresrepo.get_all
    erb :allsongs
  end

  # form to create new song
  get '/songs/new' do 
    # grab all genres and store in an instance variable
    @all_genres = Songify.genresrepo.get_all

    erb :newsong
  end

  # show a single song
  get '/songs/:id' do 
    @song = Songify.songsrepo.get(params[:id])
    @genre = Songify.genresrepo.get(@song.genre_id)

    erb :singlesong
  end

  # processes new song form & adds to database
  post '/songs' do 
    song = Songify::Song.new(song_name: params[:song_name], artist: params[:artist], album: params[:album], genre_id: params[:genre_id])
    Songify.songsrepo.add(song)
    redirect to("/songs/#{song.song_id}")
  end 

  get '/songs/:id/edit' do
    # grab all genres and store in an instance variable
    @all_genres = Songify.genresrepo.get_all

    @song = Songify.songsrepo.get(params[:id])
    @genre = Songify.genresrepo.get(@song.genre_id)

    erb :editsong
  end  

  put '/songs/:id' do
    @song = Songify.songsrepo.edit(id: params[:id], song_name: params[:song_name], artist: params[:artist], album: params[:album], genre_id: params[:genre_id])
    redirect to("/songs/#{@song.song_id}")
  end

  delete '/songs/:id/delete' do
    binding.pry
    Songify.songsrepo.delete(params[:id])
    redirect to("/songs")
  end  

  # show all genres
  get '/genres' do
    @genres = Songify.genresrepo.get_all

    erb :allgenres
  end
    
  # form to add new genre
  get '/genres/new' do
    erb :newgenre
  end

  post '/genres' do
    genre = Songify::Genre.new(genre_name: params[:genre_name])
    Songify.genresrepo.add(genre)
    redirect to("/genres")
  end

  get '/genres/:id/edit' do
    @genre = Songify.genresrepo.get(params[:id])
    erb :editgenre
  end  

  put '/genres/:id' do
    @genre = Songify.genresrepo.edit(id: params[:id], genre_name: params[:genre_name])
    redirect to("/genres")
  end

end

