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

  def total_earned
    if trips.length == 0
      total_earned = 0
    else
      earnings = []
      self.trips.each do |t|
        earnings << t.cost
      end
      total_earned = earnings.reduce(:+)
      total_earned = (total_earnings / 10.0)
      total_earned * 0.8 - 1.65
    end
    return total_earned
  end

  validates :name, presence: true
  validates :vin, presence: true, uniqueness: true
end
