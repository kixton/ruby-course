module Songify
  module Repos
    class Songs

      def add(song) # C-reate
        cmd = "INSERT INTO songs (song_name, artist, album, genre_id) VALUES ($1, $2, $3, $4) RETURNING id"
        result = Repos.db.exec(cmd, [song.song_name, song.artist, song.album, song.genre_id])
        song.instance_variable_set("@song_id", result[0]["id"].to_i)
      end

      def delete(song_id) # D-elete
        cmd = "DELETE FROM songs WHERE id = ($1)"
        Repos.db.exec(cmd, [song_id])
      end

      def get(song_id) # R-ead
        cmd = "SELECT * FROM songs WHERE id = ($1)"
        result = Repos.db.exec(cmd, [song_id]).entries
        Songify::Song.new(song_name: result[0]["song_name"], artist: result[0]["artist"], album: result[0]["album"], genre_id: result[0]["genre_id"], song_id: result[0]["id"].to_i)
      end
      
      def get_all # R-ead
        cmd = "SELECT * FROM songs ORDER BY id"
        result = Repos.db.exec(cmd)
        # result.map { |row| build(row) }
        result.map do |song|
          Songify::Song.new(song_name: song["song_name"], artist: song["artist"], album: song["album"], genre_id: song["genre_id"], song_id: song["id"].to_i)
        end  
      end

      def edit(params)
        # if genre_id is an empty_string, set it to nil 
        params[:genre_id].empty? ? genre_id = nil : genre_id = params[:genre_id]
        cmd = "UPDATE songs SET (song_name, artist, album, genre_id) = ($1, $2, $3, $4) WHERE id = $5 RETURNING *"
        result = Repos.db.exec(cmd, [params[:song_name], params[:artist], params[:album], genre_id, params[:id]]).entries 
        Songify::Song.new(song_name: result[0]["song_name"], artist: result[0]["artist"], album: result[0]["album"], genre_id: result[0]["genre_id"], song_id: result[0]["id"].to_i)
      end  

      def find(params)
        cmd = "SELECT * FROM songs WHERE () = ()"
        result = Repos.db.exec(cmd)
      end  

    end
  end
end