require 'pg'

module Songify
  module Repos

    def self.db
      @db = PG.connect(host: 'localhost', dbname: 'songify-dev')
    end

    def self.create_tables

      query = <<-SQL
        CREATE TABLE genres (
          id SERIAL PRIMARY KEY,
          genre_name TEXT
        );
      SQL
      Repos.db.exec(query)

      query = <<-SQL
        CREATE TABLE songs (
          id SERIAL PRIMARY KEY,
          song_name TEXT,
          artist TEXT,
          album TEXT,
          genre_id INTEGER REFERENCES genres (id)       
        );
      SQL
      Repos.db.exec(query)
      
    end

    def self.drop_tables
      query = <<-SQL
        DROP TABLE IF EXISTS genres CASCADE;
        DROP TABLE IF EXISTS songs CASCADE;
      SQL
      Repos.db.exec(query)
    end

    def self.populate_database
      Songify::Repos.drop_tables
      Songify::Repos.create_tables

      genre1 = Songify::Genre.new(genre_name: "Electronic")
      genre2 = Songify::Genre.new(genre_name: "Hip Hop")
      genre3 = Songify::Genre.new(genre_name: "Pop")
      genre4 = Songify::Genre.new(genre_name: "R&B")
      genre5 = Songify::Genre.new(genre_name: "Rap")
      genre6 = Songify::Genre.new(genre_name: "Rock")

      Songify.genresrepo.add(genre1)
      Songify.genresrepo.add(genre2)
      Songify.genresrepo.add(genre3)
      Songify.genresrepo.add(genre4)
      Songify.genresrepo.add(genre5)
      Songify.genresrepo.add(genre6)

      song1 = Songify::Song.new(song_name: "Dark Horse", artist: "Katy Perry", album: "Prism", genre_id: "3")
      song2 = Songify::Song.new(song_name: "Lose Yourself", artist: "Eminem", album: "Curtain Call", genre_id: 5)
      song3 = Songify::Song.new(song_name: "Crazy In Love", artist: "Beyonce", album: "Dangerously In Love")

      Songify.songsrepo.add(song1)
      Songify.songsrepo.add(song2)
      Songify.songsrepo.add(song3)

    end
  end
end
