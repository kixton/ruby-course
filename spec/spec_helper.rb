require 'rspec'
require 'pg'
require 'pry-byebug'

require_relative '../lib/songify.rb'
 
# def destroy_tables
#   db = PG.connect(host: 'localhost', dbname: 'songify-test')
#   db.exec("DROP schema public cascade;")
#   db.exec("CREATE schema public;")
# end
 
# def create_tables
#    db = PG.connect(host: 'localhost', dbname: 'songify-test')
#    Songify::Repos.create_tables
# end