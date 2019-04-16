# frozen_string_literal: true

class Driver < ApplicationRecord
  has_many :trips

  def avg_rating
    if trips.length == 0
      avg_rating = 0
    else
      ratings = []
      self.trips.each do |t|
        ratings << t.rating
      end

      avg_rating = ratings.reduce(:+).to_f / ratings.length
      avg_rating = avg_rating.round(2)
    end
    return avg_rating
  end

  def earnings
    if trips.length == 0
      total_earnings = 0
    else
      earnings = []
      self.trips.each do |t|
        earnings << t.cost
      end
      total_earnings = earnings.reduce(:+)
      total_earnings = (total_earnings / 10.0)
      total_earnings * 0.8 - 1.65
    end
    return total_earnings
  end

  validates :name, presence: true
  validates :vin, presence: true, uniqueness: true
end
