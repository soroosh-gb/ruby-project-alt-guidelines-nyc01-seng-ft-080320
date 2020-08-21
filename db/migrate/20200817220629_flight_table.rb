class FlightTable < ActiveRecord::Migration[6.0]
  def change
    create_table :flights do |t|
      t.string   :number
      t.string   :date
      t.string   :time
      t.string   :departure
      t.string   :destination
      t.integer  :price
      t.string   :seat_number
    end
  end
end
