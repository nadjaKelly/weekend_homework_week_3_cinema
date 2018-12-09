require_relative( './models/ticket' )
require_relative( '.models/film' )


require('pry-byebug')

Ticket.delete_all()
Artist.delete_all()

film1 = Film.new( {'title' => 'Fantastic Mr Fox', 'director_name' => 'Wes Anderson'} )
film1.save


film2 = Film.new ({ 'title' => 'The Avengers', 'director_name' => 'Joss Whedon'})
film2.save


ticket1 = Ticket.new ({'film_id' => film1.id, 'customer_name' => 'Jack Sparrow'})
ticket1.save

ticket2 = Ticket.new ({'film_id' => film2.id, 'customer_name' => "Gal Gadot"})
ticket2.save
