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
      Songify.songsrepo.add( Songify::Song.new("Dark Horse", "Katy Perry", "Prism") )
      Songify.songsrepo.add( Songify::Song.new("Cry Me A River", "Justin Timberlake", "Justified") )
      # add two songs to repo

      get '/songs'

      expect(last_response).to be_ok
      expect(last_response.body).to include("Dark Horse", "Cry Me A River")
    end  

  end  

  describe " GET '/songs/:id' " do
    it "shows info for single song" do
      song = Songify::Song.new("Dark Horse", "Katy Perry", "Prism")
      song2 = Songify::Song.new("Cry Me A River", "Justin Timberlake", "Justified")
      
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
    # get '/songs/new'
    # expect(last_response.body).to include("Song Name")
  end  

  describe " POST '/songs' " do
    # post '/songs'
  end

  describe " get '/songs/:id/edit' " do
    # get '/songs/:id/edit'
  end
  
  describe " put '/songs/:id' " do
    # put '/songs/:id'
  end

end