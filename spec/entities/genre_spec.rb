require_relative '../spec_helper.rb'

describe Songify::Genre do

  describe "initialize" do
    it "entity has genre name" do
      pop = Songify::Genre.new(genre_name: "Pop")
      expect(pop.genre_name).to eq("Pop")
    end
  end

end