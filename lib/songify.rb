require 'pry-byebug'
require_relative 'songify/entities/song.rb'
require_relative 'songify/entities/genre.rb'

require_relative 'songify/repos/zrepo.rb'

require_relative 'songify/repos/songsrepo.rb'
require_relative 'songify/repos/genresrepo.rb'


module Songify
  def self.songsrepo=(repo)
    @songsrepo = repo
  end

  def self.songsrepo
    @songsrepo
  end

  def self.genresrepo=(repo)
    @genresrepo = repo
  end

  def self.genresrepo
    @genresrepo
  end  
end


Songify.songsrepo = Songify::Repos::Songs.new
Songify.genresrepo = Songify::Repos::Genres.new