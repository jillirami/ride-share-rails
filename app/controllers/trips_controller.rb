# frozen_string_literal: true

class TripsController < ApplicationController
  def index
    @trips = Trip.all.order(:date)
  end

  def show
    trip_id = params[:id]
    @trip = Trip.find_by(id: trip_id)
    redirect_to drivers_path if @trip.nil?
  end

  def new
    @trip = Trip.new
  end

  def create
    trip = Trip.new(trip_params)

    is_successful = driver.save

    if is_successful
      redirect_to trip_path(trip.id)
    else
      @trip = trip
      render :new
    end
  end

  private

  def trip_params
    params.require(:trip).permit(:date, :rating, :cost, :driver_id, :passenger_id)
  end
end
