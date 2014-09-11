module Songify
  class Song

  attr_accessor :song_name, :artist, :album, :genre_id, :song_id

  def initialize(params)
    @song_name = params[:song_name]
    @artist = params[:artist]
    @album = params[:album]
    @genre_id = params[:genre_id]
    @song_id = params[:song_id]
  end  

  end    
end  
