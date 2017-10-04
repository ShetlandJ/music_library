require_relative("../db/sql_runner")
require_relative("albums")

class Album

  attr_accessor :artist_id, :title, :genre
  attr_reader :id

  def initialize(options)
    @id = options['id'].to_i if options['id']
    @artist_id = options['artist_id'].to_i
    @title = options['title']
    @genre = options['genre']
  end

  def save()
    sql = "INSERT INTO albums
    (
      artist_id,
      title,
      genre
      ) VALUES
      (
        $1, $2, $3
      )
      RETURNING id;"
      values = [@artist_id, @title, @genre]
      result = SqlRunner.run(sql, "save_album", values)
      @id = result[0]['id'].to_i
      return result
    end

    def update()
      sql = "UPDATE artists SET
      (
        artist_id,
        title,
        genre
        ) = (
          $1, $2, $3
        )
        WHERE id = $4;"
        values = [@artist_id, @title, @genre, @id]
        result = SqlRunner.run(sql, "update_artist_name", values)
      end

      def delete()
        sql = "DELETE FROM albums where id = $1"
        values = [@id]
        result = SqlRunner.run(sql, "delete_album", values)
      end

      def self.find(id)
        sql = "SELECT * FROM albums WHERE id = $1"
        values = [id]
        albums = SqlRunner.run(sql, "find_album", values)
        result = albums.map {|album| Album.new(album)}
        return result
      end

      def self.delete_all()
        sql = "DELETE FROM albums;"
        values = []
        result = SqlRunner.run(sql, "delete_all_albums", values)
      end
      #
      def self.all()
        sql = "SELECT * FROM albums"
        values = []
        albums = SqlRunner.run(sql, "find_all_albums", values)
        return albums.map { |album| Album.new(album) }
      end

      def artists()
        sql = "SELECT * FROM artists WHERE id = $1;"
        values = [@artist_id]
        results = SqlRunner.run(sql, "get_artist", values)
        artist = results[0]
        return Artist.new(artist)
      end
    end
