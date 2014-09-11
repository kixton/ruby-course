require_relative '../spec_helper.rb'

describe Songify::Song do

let(:song) { Songify::Song.new(song_name: "Dark Horse", artist: "Katy Perry", album: "Prism") }

  describe "initialize" do
    it "entity has song name, artist, album" do
      expect(song.song_name).to eq("Dark Horse")
      expect(song.artist).to eq("Katy Perry")
      expect(song.album).to eq("Prism")
    end

  end

end