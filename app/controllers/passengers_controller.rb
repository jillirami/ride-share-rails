# frozen_string_literal: true

class PassengersController < ApplicationController
  def index
    @passengers = Passenger.all.order(:name)
  end

  def show
    passenger_id = params[:id]
    @passenger = Passenger.find_by(id: passenger_id)
    redirect_to passengers_path if @passenger.nil?
  end

  def new
    @passenger = Passenger.new
  end

  def create
    passenger = Passenger.new(passenger_params)

    is_successful = passenger.save

    if is_successful
      redirect_to passenger_path(passenger.id)
    else
      @passenger = passenger
      render :new, status: :bad_request
    end
  end

  def edit
    @passenger = Passenger.find_by(id: params[:id])

    redirect_to trips_path if @passenger.nil?
  end

  def update
    passenger = Passenger.find_by(id: params[:id])

    if passenger.nil?
      redirect_to passengers_path
    else
      is_successful = Passenger.update(passenger_params)
    end

    redirect_to passenger_path(passenger.id) if is_successful
  end

  def destroy
    passenger = Passenger.find_by(id: params[:id])

    if passenger.nil?
      head :not_found
    else
      passenger.removed = false
      redirect_to passengers_path
    end
  end

  private

  def passenger_params
    params.require(:passenger).permit(:name, :phone_num)
  end
end
