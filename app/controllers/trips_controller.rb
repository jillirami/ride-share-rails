# frozen_string_literal: true

class TripsController < ApplicationController
  def index 
    @trips = Trip.all.order(:id)
  end

  def show 
    trip_id = params[:id]
    @trip = Trip.find_by(id: trip_id)
    if @trip.nil?
      head :not_found
    end
  end

  def new
    @trip = Trip.new()
  end
end
