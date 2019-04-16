# frozen_string_literal: true

class Passenger < ApplicationRecord
  has_many :trips

  def total_charged
    if self.trips.length == 0
      total_charged = 0
    else
      charges = []
      self.trips.each do |t|
        charges << t.cost
      end
      total_charged = charges.reduce(:+) / 10.0
    end
    return total_charged
  end

  validates :name, presence: :true
  validates :phone_num, presence: :true
end
