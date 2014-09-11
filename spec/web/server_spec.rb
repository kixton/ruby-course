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
    # bookly example:
    # post '/books', { "name" => "My New Book", "published_at" => "1987-06-12" }

    post '/songs', { song_name: "LaLa", artist: "Missy", album: "Limited Edition" }
    expect(last_response).to be_ok

    song = Songly.songsrepo.get_all.last
    expect(last_response.body).to include(song.song_name)

    # retrieve the last song from the repo
    # check if that song's information matches what we passed in above
  end

  describe " get '/songs/:id/edit' " do
    # get '/songs/:id/edit'
    # check if inputs have been prefilled
    # expect(last_response.body).to include("Happy")
    # similar to retrieves new song
  end
  
  describe " put '/songs/:id' " do
    # put '/songs/:id'
    # similar to post new song
  end

end