# frozen_string_literal: true

class Trip < ApplicationRecord
  belongs_to :passenger, optional: true
  belongs_to :driver, optional: true

  validates :driver_id, presence: :true
  validates :passenger_id, presence: :true
  validates :date, presence: :true
  validates :cost, presence: :true
end
