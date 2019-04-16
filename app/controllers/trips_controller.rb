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
end
