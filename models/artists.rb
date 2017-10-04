require_relative("../db/sql_runner")

class Artist

  attr_accessor :artist_name
  attr_reader :id

  def initialize(options)
    @id = options['id'].to_i if options['id']
    @artist_name = options['artist_name']
  end

  def save()
    sql = "INSERT INTO artists
    (
      artist_name
    ) VALUES
    (
      $1
    )
    RETURNING id;"
    values = [@artist_name]
    result = SqlRunner.run(sql, "save_artist", values)
    @id = result[0]['id'].to_i
    return result
  end


  def update()
    sql = "UPDATE artists SET
    (
      artist_name
    ) = (
      $1
    )
    WHERE id = $2;"
    values = [@artist_name, @id]
    result = SqlRunner.run(sql, "update_artist_name", values)
  end

  def delete()
    sql = "DELETE FROM artists where id = $1"
    values = [@id]
    result = SqlRunner.run(sql, "delete_artist", values)
  end

  def self.find(id)
    sql = "SELECT * FROM artists WHERE id = $1"
    values = [id]
    artists = SqlRunner.run(sql, "find_artist", values)
    result = artists.map {|artist| Artist.new(artist)}
    return result
  end

  def self.delete_all()
    sql = "DELETE FROM artists;"
    values = []
    result = SqlRunner.run(sql, "delete_all_artists", values)
  end

  def self.all()
    sql = "SELECT * FROM artists"
    values = []
    artists = SqlRunner.run(sql, "find_all_artists", values)
    return artists.map { |artist| Artist.new(artist) }
  end

#   def pizzas()
#     sql = "SELECT * FROM pizza_orders WHERE customer_id = $1;"
#     values = [@id]
#     results = SqlRunner.run(sql, "get_pizzas", values)
#     return results.map { |order| PizzaOrder.new(order) }
#   end
#
end
