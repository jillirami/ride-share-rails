class Driver < ApplicationRecord
  has_many :trips

  def avg_rating
    ratings = []
    self.trips.each do |t|
      ratings << t.rating
    end
    avg_rating = ratings.inject{ |sum, el| sum + el }.to_f / ratings.length 
    return avg_rating.round(2)
  end

  validates :name, presence: true
  validates :vin, presence: true, uniqueness: true
end
