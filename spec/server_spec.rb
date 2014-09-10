
require 'server_spec_helper'

describe Songify::Server do 

  def app
    Songify::Server.new
  end  
  
  describe " GET '/songs' " do
  end  

  describe " GET '/songs/:id' " do
    # redirect 
  end  

  describe " GET '/songs/new' " do
    # form
    # method = "post" action = '/songs' 
  end  

  describe " POST '/songs' " do
    # create song
    # redirect to 
  end  

end