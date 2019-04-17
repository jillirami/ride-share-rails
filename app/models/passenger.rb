# frozen_string_literal: true

class Passenger < ApplicationRecord
  has_many :trips

  def total_charged
    if trips.empty?
      total_charged = 0
    else
      charges = []
      trips.each do |t|
        if t.cost == nil
          total_charged = 0
        else
          charges << t.cost
        end
      end
      total_charged = charges.reduce(:+) / 10.0
    end
    total_charged
  end

  validates :name, presence: :true
  validates :phone_num, presence: :true
end
