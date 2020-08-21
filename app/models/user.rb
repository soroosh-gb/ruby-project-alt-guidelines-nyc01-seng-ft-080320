class User < ActiveRecord::Base
    has_many :bookings
    has_many :flights, through: :bookings

    def self.login(username, password)
        user = User.find_by(username: username, password: password)
        user
    end

end