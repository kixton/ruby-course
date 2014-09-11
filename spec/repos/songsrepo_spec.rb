require_relative '../spec_helper.rb'

describe Songify::Repos::Songs do

  let(:song) { Songify::Song.new(song_name: "Dark Horse", artist: "Katy Perry", album: "Prism") }
  let(:song2) { Songify::Song.new(song_name: "Cry Me A River", artist: "Justin Timberlake", album: "Justified") }

  before(:all) do
    Songify::Repos.instance_variable_set(:@db, PG.connect(host: 'localhost', dbname: 'songify-test'))
  end

  before(:each) do
    Songify::Repos.drop_tables
    Songify::Repos.create_tables
    
    Songify.songsrepo.add(song)
    Songify.songsrepo.add(song2)
  end

  describe "#add" do
    it "adds song to songs repo and sets song_id" do
      expect(song.song_id).to eq(1)
    end
  end

  describe "#get" do
    it "returns a specific song" do
      result = Songify.songsrepo.get(song.song_id)
      expect(result).to be_a(Songify::Song)
      expect(result.song_name).to eq("Dark Horse")
    end
  end

  describe "#get_all" do
    it "returns all songs" do
      result = Songify.songsrepo.get_all

      expect(result).to be_an(Array)
      expect(result.length).to eq(2)

      expect(result[0].artist).to eq("Katy Perry")
      expect(result[1].song_name).to eq("Cry Me A River")
    end
  end  

  describe "#delete" do
    it "deletes a song" do
      result = Songify.songsrepo.get_all
      expect(result.length).to eq(2)

      Songify.songsrepo.delete(song2.song_id)
      result2 = Songify.songsrepo.get_all
      expect(result2.length).to eq(1)
    end
  end

  describe "#edit" do
    it "updates song name" do
      pop = Songify::Genre.new(genre_name: "Pop")
      Songify.genresrepo.add(pop)

      Songify.songsrepo.edit(id: "1", song_name: "New Song Name", artist: "Katy Perry", album: "New Album", genre_id: "1")
      
      result = Songify.songsrepo.get(song.song_id)
      expect(result.song_name).to eq("New Song Name")
    end
  end  


end
