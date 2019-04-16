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
      render :new
    end
  end

  private

  def passenger_params
    params.require(:passenger).permit(:name, :phone_num)
  end
end
