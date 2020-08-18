class BookingTable < ActiveRecord::Migration[6.0]
  def change
    create_table :bookings  do |t|
    t.integer :flight_id
    t.integer :user_id
    end
  end
end
