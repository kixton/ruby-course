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
        cmd = "SELECT * FROM songs"
        result = Repos.db.exec(cmd)
        # result.map { |row| build(row) }
        result.map do |song|
          Songify::Song.new(song_name: song["song_name"], artist: song["artist"], album: song["album"], genre_id: song["genre_id"], song_id: song["id"].to_i)
        end  
      end

      def edit(song_id, params)
        cmd = "UPDATE songs SET (song_name, artist, album, genre_id) = ('#{params[:song_name]}', '#{params[:artist]}', '#{params[:album]}', '#{params[:genre_id]}') WHERE id = '#{song_id}' RETURNING *"
        result = Repos.db.exec(cmd).entries 
        Songify::Song.new(song_name: result[0]["song_name"], artist: result[0]["artist"], album: result[0]["album"], genre_id: result[0]["genre_id"], song_id: result[0]["id"].to_i)
      end  

    end
  end
end