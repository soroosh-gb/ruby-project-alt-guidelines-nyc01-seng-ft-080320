require 'pry'

class CLI
    def welcome
        puts "Hello, welcome to FlyEz"
        user = self.login
        if user == nil
            return
        end
        menu(user)
    end 

    def menu(user)
        puts "What do you want to do? (enter the number)"
        puts "1. Check Flight"
        puts "2. Book Flight"
        puts "3. Cancel Flight"
        puts "4. Update Flight(Change Seat)"
        puts "5. Exit"
            
        action = gets.chomp.to_i
        if action == 1
            self.check_flight(user)
        elsif action == 2
            self.book_flight(user)
        elsif action == 3
            self.cancel_flight(user)
        elsif action == 4
            self.update_flight(user)
        elsif action == 5
            Kernel.exit
        else
            puts "Please enter a valid option."
            menu(user)
        end
    end

    def login
        puts "Please enter your USERNAME:"
        username = gets.chomp.to_s.upcase

        puts "Please enter your PASSWORD:"
        password = gets.chomp.to_i
        user = User.login(username, password)
        if user == nil
            puts "Username or Password is Wrong!!!"
            puts "Try again:"
            login
        else
            puts "Hi #{user.username}!"
        end
        user
    end

    def stay_or_go(user) 
        puts "Would you like to go back to the menu? Y/N"
        user_response = gets.chomp.to_s.upcase
        if user_response == "Y" 
            menu(user)
        else
            Kernel.exit
        end
    end
    
    def flight_list(user) 
        i = 1
        user.flights.each do |flight| 
            puts "#{i}. Flight Number: #{flight.number} - Date: #{flight.date} - Time: #{flight.time} - Departure: #{flight.departure} - Destination: #{flight.destination} - Seat: #{flight.seat_number}"
            i += 1   
        end
    end


    def check_flight(user)
        puts "Checking flights"
        if  (user.flights).count == 0
            puts "You have not booked any flight yet!"
            stay_or_go(user)
        else
            puts "Your Bookings:"
            flight_list(user)
            stay_or_go(user)
        end
    end


    def book_flight(user)
        puts "Booking flight"
        puts "From:"
        dep = gets.chomp.to_s.upcase
        puts "To:"
        des = gets.chomp.to_s.upcase
        puts "Date: (dd.mm.yyyy)"
        date = gets.chomp.to_s
        found_flight = nil
        Flight.all.each do |flight|
            if flight.departure == dep and flight.destination == des and flight.date == date
                found_flight = flight
            end
        end
        if  found_flight == nil
            puts "Sorry, there is no flight available for #{des} on #{date}."
            stay_or_go(user)
        else
            puts "Available flight:"
            puts "#Flight Number: #{found_flight.number} - Date: #{found_flight.date} - Time: #{found_flight.time} - Departure: #{found_flight.departure} - Destination: #{found_flight.destination} - Price: $#{found_flight.price}"
            puts "Would you like to book this flight? Y/N"
            input = gets.chomp.to_s.upcase
            if input == "Y"
                Booking.create(user: user,flight: found_flight)
                puts "Awsome, your flight to #{found_flight.destination} is successfully booked!" 
                stay_or_go(user)
            elsif input == "N"
                stay_or_go(user)
            end
        end
    end

    
    def cancel_flight(user)
        puts "Your Bookings:"
        if  (user.flights).count == 0
            puts "You do not have a booking yet!"
        else
            flight_list(user) 
            puts "Please enter the flight number you want to cancel:"
            flight_num = gets.chomp.to_s.upcase
            found_flight = nil
            user.flights.each do |fl| 
                if  fl.number == flight_num 
                    found_flight = fl
                end
            end
            if found_flight == nil
                puts "Invalid flight number. Would you like to try again? Y/N"
                user_response = gets.chomp.to_s.upcase
                if  user_response == "Y"
                    cancel_flight(user)
                else
                    stay_or_go(user)
                end 
            else 
                self.remove_booking(flight_num)
                puts "You have seccessfully canclled your booking" 
                stay_or_go(user) 
            end
        end
    end

    def remove_booking(flight_number)
        Booking.all.each do |booking|
           if booking.flight.number == flight_number
              booking.delete
           end
        end
    end
     
    def update_flight(user)
        puts "Change Seat"
        flight_list(user)
        puts "Please enter the flight number you want to update:"
        flight_num = gets.chomp.to_s.upcase
        puts "Please choose from available seats:"
        puts "17F","21D","16A","15C","32G"
        new_seat = gets.chomp.to_s.upcase
        user.flights.each do |fl|
            if fl.number == flight_num
                fl.seat_number = new_seat
                puts "Flight is updated:"
                puts "Flight Number: #{fl.number} - Date: #{fl.date} - Time: #{fl.time} - Departure: #{fl.departure} - Destination: #{fl.destination} - Seat: #{fl.seat_number}"
            end
        end
        stay_or_go(user)
    end
end


