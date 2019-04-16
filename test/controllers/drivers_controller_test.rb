# frozen_string_literal: true

require 'test_helper'

describe DriversController do
  let (:driver) do
    Driver.create name: 'name', vin: 'fjoij67'
  end

  describe 'index' do
    it 'can get index' do
      get drivers_path

      must_respond_with :success
    end

    it 'can get the root path' do
      get root_path

      must_respond_with :success
    end
  end

  describe 'show' do
    it 'can get a valid driver' do
      get driver_path(driver.id)

      must_respond_with :success
    end

    it 'will redirect for an invalid driver' do
      get driver_path(-1)

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
    it 'can get to the new driver page' do
      get new_driver_path

      must_respond_with :success
    end
  end

  describe 'create' do
    it 'can create a new driver' do
      driver_hash = {
        driver: {
          name: 'new driver',
          vin: 'new vin'
        }
      }

      expect do
        post drivers_path, params: driver_hash
      end.must_change 'Driver.count', 1

      new_driver = Driver.find_by(name: driver_hash[:driver][:name])

      expect(new_driver.vin).must_equal driver_hash[:driver][:vin]

      must_respond_with :redirect
      must_redirect_to driver_path(new_driver.id)
    end

    it "will redirect to 'new' form if there are any errors" do
      driver_hash = {
        driver: {
          name: '',
          vin: 'new vin'
        }
      }

      expect do
        post drivers_path, params: driver_hash
      end.wont_change 'Driver.count'

      must_respond_with :redirect
      must_redirect_to new_driver_path
    end
  end

  describe 'destroy' do
    # Your tests go here
  end
end
