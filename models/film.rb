require_relative('../db/sql_runner')


class Film


attr_accessor :title, :director_name
attr_reader :id

def initialize(options)
  @id = options['id'].to_i
  @title = options['title']
  @director_name = options['director_name']
end

def save()
  sql = "INSERT INTO films (title, director_name) VALUES ($1, $2) RETURNING id"
  values = [@title, @director_name]
  @id = SqlRunner.run(sql, values)[0]["id"].to_i
end


def tickets()
  sql = "SELECT * FROM albums
  WHERE id = $1"
  values = [@id]
  tickets = SqlRunner.run(sql, values)
  result = tickets.map { |ticket_hash| Ticket.new( ticket_hash)}
  return result
end


def update()
  sql = "UPDATE films SET (name = ($1) WHERE id = $2"
  values = [@title, @director_name, @id]
  SqlRunner.run(sql, values)
end


def delete()
  sql = "DELETE FROM films WHERE id = $1"
  values = [@id]
  SqlRunner.run(sql, values)
end

def self.all()
  sql = "SELECT * FROM films"
  films = SqlRunner.run(sql)
  result = films.map {|ticket_hash| Film.new(ticket_hash)}
  return result
end


def self.delete_all()
  sql = "DELETE FROM films"
  SqlRunner.run(sql)
end

def self.find(id)
  sql = "SELECT * FROM films WHERE id = $1"
  values = [id]
  array_of_film_hashes = SqlRunner.run(sql, values)
  film = self.new(array_of_film_hashes.first)
  return film
end




end
