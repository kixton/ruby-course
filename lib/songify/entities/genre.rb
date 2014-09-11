module Songify
  class Genre

  attr_accessor :genre_name, :genre_id

  def initialize(params)
    @genre_name = params[:genre_name]
    @genre_id = params[:genre_id]
  end  

  end    
end  
