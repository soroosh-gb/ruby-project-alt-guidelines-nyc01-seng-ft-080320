Flight.destroy_all
User.destroy_all
Booking.destroy_all 

f1=Flight.create(number: 234,date:"08.07.20",time:"12:00",departure: "NYC",destination: "MIA",price: 100, available_seats: 125)
f2=Flight.create(number: 50,date: "08.07.20",time: "12:00",departure: "NYC",destination: "MIA",price: 100, available_seats: 230)

alex=User.create(username: "Alex", password: 1234)
sam=User.create(username:"Sam", password: 4567)

b1=Booking.create(user: alex, flight: f2)
b2=Booking.create(user: sam, flight: f1)
