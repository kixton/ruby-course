require 'server_spec_helper'
require 'pry-byebug'

describe Songify::Server do 

  def app
    Songify::Server.new
  end  

  before(:all) do
    Songify::Repos.instance_variable_set(:@db, PG.connect(host: 'localhost', dbname: 'songify-test'))
  end

  before(:each) do
    Songify::Repos.drop_tables
    Songify::Repos.create_tables
  end

  describe " GET '/songs' " do
    it "shows all songs" do
      Songify.songsrepo.add( Songify::Song.new(song_name: "Dark Horse", artist: "Katy Perry", album: "Prism") )
      Songify.songsrepo.add( Songify::Song.new(song_name: "Cry Me A River", artist: "Justin Timberlake", album: "Justified") )
      # add two songs to repo

      get '/songs'

      expect(last_response).to be_ok
      expect(last_response.body).to include("Dark Horse", "Cry Me A River")
    end  

  end  

  describe " GET '/songs/:id' " do
    it "shows info for single song" do
      song = Songify::Song.new(song_name: "Dark Horse", artist: "Katy Perry", album: "Prism")
      song2 = Songify::Song.new(song_name: "Cry Me A River", artist: "Justin Timberlake", album: "Justified") 
      
      Songify.songsrepo.add(song)
      Songify.songsrepo.add(song2)

      get '/songs/1'
      expect(last_response).to be_ok
      expect(last_response.body).to include("Dark Horse")

      get '/songs/2'
      expect(last_response).to be_ok
      expect(last_response.body).to include("Cry Me A River")
    end

  end  

  describe " GET '/songs/new' " do
    it "retrieves 'Add New Song' page" do
      get '/songs/new'
      expect(last_response).to be_ok
      expect(last_response.body).to include("Add New Song")
    end
  end  

  describe " POST '/songs' " do
    it "adds new song to repo" do
      post '/songs', { song_name: "LaLa", artist: "Missy", album: "Limited Edition"}
      expect(last_response).to be_redirect

      # retrieve the last song from the repo
      song = Songify.songsrepo.get_all.last
      # check if that song's information matches what we passed in above
      expect(song.song_name).to eq("LaLa")
    end  
  end

  describe " GET '/songs/:id/edit' " do
    it "retrieves 'Edit Song' page" do
      song = Songify::Song.new(song_name: "Dark Horse", artist: "Katy Perry", album: "Prism")
      Songify.songsrepo.add(song)

      get '/songs/1/edit'
      expect(last_response).to be_ok
      expect(last_response.body).to include("Edit Song")
      expect(last_response.body).to include("Dark Horse")
      # check if inputs have been prefilled
    end  
  end
  
  describe " GET '/songs/:id' " do
    it "updates song information" do
      rock = Songify::Genre.new(genre_name: "Rock")
      Songify.genresrepo.add(rock)
      Songify.songsrepo.add( Songify::Song.new(song_name: "Dark Horse", artist: "Katy Perry", album: "Prism") )
      put '/songs/1', { song_name: "New Song Name", artist: "New Artist", album: "Prism", genre_id: "1", id: "1" }
    end  
  end

  describe " DELETE '/songs/:id/delete " do 
    it "deletes a song" do
      song = Songify::Song.new(song_name: "Dark Horse", artist: "Katy Perry", album: "Prism")
      song2 = Songify::Song.new(song_name: "Cry Me A River", artist: "Justin Timberlake", album: "Justified") 
      
      Songify.songsrepo.add(song)
      Songify.songsrepo.add(song2)

      song_list = Songify.songsrepo.get_all
      expect(song_list.length).to eq(1)

      delete '/songs/1/delete'

      expect(last_response).to be_ok
      song_list = Songify.songsrepo.get_all
      expect(song_list.length).to eq(1)

    end  
  end


  # describe " GET '/genres' " do
  #   it "shows all genres and genre ID" do
  #     Songify.genresrepo.add( Songify::Genre.new(genre_name: "Pop") )
  #     Songify.genresrepo.add( Songify::Genre.new(genre_name: "Country") )

  #     get '/genres'

  #     expect(last_response.body).to include("ID: 1")
  #     expect(last_response.body).to include("Country")
  #   end
  # end  

  # describe " GET '/genres/new' " do
  #   it "retrives form to add new genre" do
  #     get '/genres/new'
  #     expect(last_response).to be_ok
  #     expect(last_response.body).to include("Add New Genre")
  #   end
  # end  

  # describe " POST '/songs' " do
  #   it "adds new genre to repo" do
  #     post '/genres', { genre_name: "Hip Hop"}
  #     expect(last_response).to be_redirect

  #     genre = Songify.genresrepo.get_all.last
  #     expect(genre.genre_name).to eq("Hip Hop")
  #   end  
  # end

end