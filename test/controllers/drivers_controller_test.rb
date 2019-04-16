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
    it "can get the edit page for an existing driver" do
      get edit_driver_path(driver.id)
      must_respond_with :success
    end

    it "will respond with redirect when attempting to edit a nonexistant driver" do
      get edit_driver_path(-1)
      must_respond_with :redirect
    end
  end

  describe 'update' do
    driver_hash = {
      driver: {
        name: 'new name', vin: 'new vin'
      },
    }

    it "can update an existing driver" do
      id = Driver.first.id
      expect {
        patch driver_path(id), params: driver_hash
      }.wont_change "Driver.count"
    end

    it "will redirect to the root page if given an invalid id" do
      patch driver_path(-1), params: driver_hash
      
      must_respond_with :redirect
    end
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
    it "returns a 404 if the driver if not found" do
      invalid_id = "NOT A VALID ID"

      expect {
        delete driver_path(invalid_id)
      }.wont_change "Driver.count"

      must_respond_with :not_found
    end

    it "can delete a driver" do
      new_driver = Driver.create(name: "Jillianne")

      expect {
        delete driver_path(new_driver.id)
      }.must_change "Driver.count", -1

      must_respond_with :redirect
      must_redirect_to drivers_path
    end
  end
end
