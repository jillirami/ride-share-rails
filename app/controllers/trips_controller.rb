# frozen_string_literal: true

class TripsController < ApplicationController
  def index
    @trips = if params[:passenger_id]
               Trip.where(passenger: Passenger.find_by(id: [:passenger_id]))
             else
               Trip.all.order(:date)
             end
  end

  def show
    trip_id = params[:id]
    @trip = Trip.find_by(id: trip_id)
    redirect_to trips_path if @trip.nil?
  end

  def new
    @trip = Trip.new
  end

  def create
    # find passenger
    passenger = params[:passenger_id].to_i
    driver = Driver.find_by(status: true)
    # find driver
    @trip = Trip.new(
      passenger_id: passenger,
      driver_id: driver.id,
      date: DateTime.now,
      cost: rand(20..100) # random number between 200 - 10000 cents (2-100 dollars)
    )

    is_successful = @trip.save

    if is_successful
      driver.status = false
      driver.save
      redirect_to passenger_path(@trip.passenger_id)
    else
      flash[:error] = 'There was a problem'
      redirect_to root_path
    end
  end

  def edit
    @trip = Trip.find_by(id: params[:id])

    redirect_to trips_path if @trip.nil?
  end

  def update
    trip = Trip.find_by(id: params[:id])

    if trip.nil?
      redirect_to trips_path
    else
      is_successful = trip.update(trip_params)
    end

    redirect_to passenger_path(trip.passenger_id) if is_successful
  end

  def destroy
    trip = Trip.find_by(id: params[:id])
    passenger = trip.passenger_id

    trip.destroy
    redirect_to passenger_path(passenger)
  end

  private

  def trip_params
    params.require(:trip).permit(:date, :rating, :cost, :driver_id, :passenger_id)
  end
end
