Flight.destroy_all
User.destroy_all
Booking.destroy_all 

f1 = Flight.create(number: "FE234",date:"01.01.2020",time:"11:00",departure: "NEW YORK",destination: "FLORIDA",price: 150,seat_number: "23B")
f2 = Flight.create(number: "WW50",date: "19.02.2020",time: "22:00",departure: "BERLIN",destination: "NEW YORK",price: 100, seat_number: "14D" )
f3 = Flight.create(number: "KH4322",date: "16.12.2020",time: "10:00",departure: "DETROIT",destination: "NEW YORK",price: 275, seat_number: "12F" )
f4 = Flight.create(number: "LI897",date: "20.10.2020",time: "09:00",departure: "NEW YORK",destination: "BOSTON",price: 210, seat_number: "25G" )

john =User.create(username: "JOHN", password: 1234)
ted = User.create(username:"TED", password: 1234)


b1 = Booking.create(user: john, flight: f2)
b2 = Booking.create(user: ted, flight: f1)
b3 = Booking.create(user: ted, flight: f3)
b2 = Booking.create(user: ted, flight: f4)

