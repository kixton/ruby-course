require_relative '../spec_helper.rb'

describe Songify::Repos::Genres do

  let(:pop) { Songify::Genre.new(genre_name: "Pop") }

  before(:all) do
    Songify::Repos.instance_variable_set(:@db, PG.connect(host: 'localhost', dbname: 'songify-test'))
  end

  before(:each) do
    Songify::Repos.drop_tables
    Songify::Repos.create_tables
    
    Songify.genresrepo.add(pop)
  end

  describe "#add" do
    it "adds genre to genres repo and sets genre_id" do
      expect(pop.genre_id).to eq(1)
    end
  end

  describe "#get" do
    it "returns a specific genre" do
      result = Songify.genresrepo.get(pop.genre_id)
      expect(result).to be_a(Songify::Genre)
      expect(result.genre_name).to eq("Pop")
    end
  end

  describe "#get_all" do
    it "returns all genres" do
      rock = Songify::Genre.new(genre_name: "Rock")
      Songify.genresrepo.add(rock)

      result = Songify.genresrepo.get_all
      expect(result).to be_an(Array)
      expect(result[0].genre_name).to eq("Pop")
      expect(result[1].genre_name).to eq("Rock")
    end
  end  

end
