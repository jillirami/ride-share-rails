# frozen_string_literal: true

require 'test_helper'
require 'pry'

describe TripsController do
  let (:trip) do
    Trip.create(passenger_id: Passenger.first.id, driver_id: Driver.find_by(status: true).id, cost: 20, date: '2019-01-11')
  end
  describe 'show' do
    it 'can get the show page for a trip' do
      get trip_path(trip.id)

      must_respond_with :success
    end

    it 'will redirect for an invalid trip' do
      get trip_path(-1)

      must_respond_with :redirect
    end
  end

  describe 'edit' do
    it 'can get the edit page for an existing trip' do
      get edit_trip_path(trip.id)
      must_respond_with :success
    end

    it 'will respond with redirect when attempting to edit a nonexistant trip' do
      get edit_trip_path(-1)
      must_respond_with :redirect
    end
  end

  describe 'update' do
    # this test has gone from passing to failing to passing so many times and I can't figure out why.
    # I've probably spent 3 hours on this test alone.
    it 'can update an existing trip' do
      trip_hash = {
        "trip": {
          date: '2019-10-10',
          cost: 27.56,
          passenger_id: Passenger.last.id,
          driver_id: Driver.find_by(status: true)
        }
      }

      expect do
        patch trip_path(trip.id), params: trip_hash
      end.wont_change 'Trip.count'
    end

    it 'will redirect to the root page if given an invalid trip' do
      trip_hash = {
        "trip": {
          date: '2019-10-10',
          cost: 27.56,
          passenger_id: Passenger.last.id,
          driver_id: Driver.last.id
        }
      }
      patch trip_path(-1), params: trip_hash

      must_respond_with :redirect
    end
  end

  describe 'create' do
    it 'will save a new trip and redirect if given valid inputs' do
      # Arrange
      input_date = '2019-10-12'
      input_rating = nil
      input_cost = 35.42

      trip_hash  = {
        "trip": {
          date: input_date,
          cost: input_cost,
          passenger_id: Passenger.last.id,
          driver_id: Driver.last.id
        }
      }
      # Act
      expect do
        post trips_path params: trip_hash
      end.must_change 'Trip.count', 1

      # Assert
      new_trip = Trip.last
      expect(new_trip).wont_be_nil
      expect(new_trip.rating).must_equal nil

      must_respond_with :redirect
    end

    it 'will return a bad request with an invalid trip' do
      # Arrange
      input_date = '',
                   input_rating = nil,
                   input_cost = 35.42

      test_input = {
        "trip": {
          passenger_id: 0,
          driver_id: 1,
          date: input_date,
          rating: input_rating,
          cost: input_cost
        }
      }

      # Act
      expect do
        post trips_path, params: test_input
      end.wont_change 'Trip.count'
      # .must_change "Book.count", 0

      # Assert
      must_redirect_to root_path
    end
  end

  describe 'destroy' do
    it 'can delete a trip' do
      # Arrange - Create a trip
      passenger = Passenger.create(name: 'Ariana', phone_num: 3_033_033_030)
      driver = Driver.find_by(status: true)

      new_trip = passenger.trips.create(passenger_id: 4, driver_id: driver.id, cost: 50.0, date: '2019-05-04')
      expect do
        # Act
        delete trip_path(new_trip.id)

        # Assert
      end.must_change 'Trip.count', -1

      must_respond_with :redirect
      must_redirect_to passenger_path(new_trip.passenger_id)
    end
  end
end
