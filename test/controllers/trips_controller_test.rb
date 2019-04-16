# frozen_string_literal: true

require 'test_helper'

describe TripsController do
  describe 'show' do
    # Your tests go here
  end

  describe 'edit' do
    # Your tests go here
  end

  describe 'update' do
    # Your tests go here
  end

  describe 'create' do
    it 'will save a new trip and redirect if given valid inputs' do
      # Arrange
      input_date = 2019 - 0o5 - 0o4
      input_rating = nil
      input_cost = 35.42
      test_input = {
        "trip": {
          date: input_title,
          rating: input_rating,
          cost: input_cost
        }
      }

      # Act
      expect do
        post trips_path, params: test_input
      end.must_change 'Trip.count', 1

      # Assert
      trip_path = Trip.find_by(cost: input_cost)
      expect(new_trip).wont_be_nil
      expect(new_trip.date).must_equal input_date
      expect(new_trip.rating).must_equal nil
      expect(new_trip.cost).must_equal input_cost

      must_respond_with :redirect
    end

    it 'will return a 400 with an invalid trip' do
      # Arrange
      input_date = '',
                   input_rating = nil,
                   input_cost = 35.42

      test_input = {
        "trip": {
          date: input_title,
          rating: input_rating,
          cost: input_cost
        }
      }

      # Act
      expect do
        post books_path, params: test_input
      end.wont_change 'Trip.count'
      # .must_change "Book.count", 0

      # Assert
      must_respond_with :bad_request
    end
  end

  describe 'destroy' do
    # Your tests go here
  end
end
