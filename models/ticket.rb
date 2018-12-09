require_relative('../db/sql_runner')

class Ticket

  attr_accessor :film_id; :customer_name
  attr_reader :id

  def initialize(options)
    @id = options['id'].to_i
    @film_id = options["film_id"]
    @customer_name = options['customer_name']
  end

  def save()
    sql = "INSERT INTO  tickets (film_id, customer_name) VALUES ($1, $2) RETURNING id"
    values = [@film_id, @customer_name]
    @id = SqlRunner.run(sql, values)[0]["id"].to_i
  end

  def film()
    sql = "SELECT * FROM films WHERE id = $1"
    values = [@film_id]
    film = SqlRunner.run(sql, values)
    result = Film.new(film.first)
    return result
  end

  def update
    sql = "UPDATE tickets SET film_id = $1, customer_name = $2 WHERE id = $3"
    values = [@film_id, @customer_name, @id]
    SqlRunner.run(sql, values)
  end

  def delete()
    sql = "DELETE FROM tickets WHERE id = $1"
    values = [@id]
    SqlRunner.run(sql, values)
  end

  def self.all()
    sql = "SELECT * FROM tickets"
    tickets = SqlRunner.run(sql)
    result = tickets.map { |ticket_hash| Ticket.new(ticket_hash)}
    return result
  end

  def self.delete_all()
    sql = "DELETE FROM tickets"
    SqlRunner.run(sql)
  end

  def self.find(id)
    sql = "SELECT * FROM tickets WHERE id = $1"
    values = [id]
    array_of_ticket_hashes = SqlRunner.run(sql, values)
    ticket = self.new(array_of_ticket_hashes.first)
    return ticket
  end
  
end
