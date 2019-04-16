# frozen_string_literal: true

class Driver < ApplicationRecord
  has_many :trips

  validates :name, presence: :true
  validates :vin, presence: :true

  def avg_rating
    if trips.nil?
      avg_rating = nil
    else
      ratings = []
      trips.each do |t|
        ratings << t.rating
      end
      avg_rating = ratings.reduce(:+).to_f / ratings.length
      avg_rating = avg_rating.round(2)
    end

    return avg_rating
  end

  def earnings
    if trips.nil?
      total_earning = nil
    else
      earnings = []
      trips.each do |t|
        earnings << t.cost
      end

      total_earning = earnings.reduce(:+)
      total_earning = (total_earning / 10.0)
      total_earning = total_earning * 0.8 - 1.65
    end

    return total_earning
  end

  validates :name, presence: true
  validates :vin, presence: true, uniqueness: true
end
