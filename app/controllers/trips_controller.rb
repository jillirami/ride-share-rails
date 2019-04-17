# frozen_string_literal: true

class TripsController < ApplicationController
  def index
    if params[:passenger_id]
      @trips = Trip.where(passenger: Passenger.find_by(id: [:passenger_id]))
    else
      @trips = Trip.all.order(:date)
    end
  end

  def show
    trip_id = params[:id]
    @trip = Trip.find_by(id: trip_id)
    redirect_to trips_path if @trip.nil?
  end

  def new
    if params[:passenger_id]
      @trip = Trip.new(passenger: Passenger.find_by(id: params[:passenger_id]))
    else
      @trip = Trip.new
    end
  end

  def create
    @trip = Trip.new(trip_params)

    is_successful = @trip.save

    if is_successful
      redirect_to trip_path(@trip.id)
    else
      render :new, status: :bad_request
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
      is_successful = Trip.update(trip_params)
    end

    redirect_to trip_path(trip.id) if is_successful
  end

  def destroy
    trip = Trip.find_by(id: params[:id])

    if trip.nil?
      head :not_found
    else
      trip.destroy
      redirect_to trips_path
    end
  end

  private

  def trip_params
    params.require(:trip).permit(:date, :rating, :cost, :trip_id, :passenger_id)
  end
end
