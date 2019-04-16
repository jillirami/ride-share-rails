# frozen_string_literal: true

class Driver < ApplicationRecord
  has_many :trips

  validates :name, presence: :true
  validates :vin, presence: :true

  def avg_rating
    ratings = []
    trips.each do |t|
      ratings << t.rating
    end
    avg_rating = ratings.inject { |sum, el| sum + el }.to_f / ratings.length
    avg_rating.round(2)
  end

  validates :name, presence: true
  validates :vin, presence: true, uniqueness: true
end
