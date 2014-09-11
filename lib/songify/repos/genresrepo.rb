module Songify
  module Repos
    class Genres

      def add(genre) # .add takes an instance of Genre class
        cmd = "INSERT INTO genres (genre_name) VALUES ($1) RETURNING id"
        result = Repos.db.exec(cmd, [genre.genre_name])
        genre.instance_variable_set("@genre_id", result[0]["id"].to_i)
      end

      def get(genre_id) 
        if !genre_id
          return
        end
        cmd = "SELECT * FROM genres WHERE id = ($1)"
        result = Repos.db.exec(cmd, [genre_id]).entries
        Songify::Genre.new(genre_name: result[0]["genre_name"], genre_id: result[0]["id"].to_i)
      end
      
      def get_all 
        cmd = "SELECT * FROM genres"
        result = Repos.db.exec(cmd)
        result.map do |genre|
          Songify::Genre.new(genre_name: genre["genre_name"], genre_id: genre["id"].to_i)
        end  
      end

      def edit(params)
        cmd = "UPDATE genres SET (genre_name) = ($1) WHERE id = $2 RETURNING *"
        result = Repos.db.exec(cmd, [ params[:genre_name], params[:id] ]).entries 
        Songify::Genre.new(genre_name: result[0]["genre_name"], genre_id: result[0]["id"].to_i)
      end  

    end
  end
end