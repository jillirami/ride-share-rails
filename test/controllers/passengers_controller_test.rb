# frozen_string_literal: true

require 'test_helper'

describe PassengersController do
  let (:passenger) do
    Passenger.create name: 'passenger name', phone_num: '4404443020'
  end

  describe 'index' do
    it 'can get index' do
      get passengers_path

      must_respond_with :success
    end

    it 'can get the root path' do
      get root_path

      must_respond_with :success
    end
  end

  describe 'show' do
    it 'can get the show page for a passenger' do
      get passenger_path(passenger.id)

      must_respond_with :success
    end

    it 'will redirect for an invalid passenger' do
      get passenger_path(-1)

      must_respond_with :redirect
    end
  end

  describe 'edit' do
    # Your tests go here
  end

  describe 'update' do
    # Your tests go here
  end

  describe 'new' do
    it 'can get to the new passenger page' do
      get new_passenger_path

      must_respond_with :success
    end
  end

  describe 'create' do
    it 'can create a new passenger' do
      passenger_hash = {
        passenger: {
          name: 'new passenger',
          phone_num: '3334445555'
        }
      }

      expect do
        post passengers_path, params: passenger_hash
      end.must_change 'Passenger.count', 1

      new_passenger = Passenger.find_by(name: passenger_hash[:passenger][:name])

      expect(new_passenger.phone_num).must_equal passenger_hash[:passenger][:phone_num]

      must_respond_with :redirect
      must_redirect_to passenger_path(new_passenger.id)
    end

    it "will redirect to 'new' form if there are any errors" do
      passenger_hash = {
        passenger: {
          name: '',
          phone_num: 'new vin'
        }
      }

      expect do
        post passengers_path, params: passenger_hash
      end.wont_change 'Passenger.count'

      must_respond_with :redirect
      must_redirect_to new_passenger_path
    end

  end

  describe 'destroy' do
    # Your tests go here
  end
end
