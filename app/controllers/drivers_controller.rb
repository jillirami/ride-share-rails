# frozen_string_literal: true

class DriversController < ApplicationController
  def index
    @drivers = Driver.all.order(:id)
  end

  def show
    driver_id = params[:id]
    @driver = Driver.find_by(id: driver_id)
    redirect_to drivers_path if @driver.nil?
  end

  def new
    @driver = Driver.new
  end

  def create
    driver = Driver.new(driver_params)

    is_successful = driver.save

    if is_successful
      redirect_to driver_path(driver.id)
    else
      @driver = driver
      render :new
    end
  end

  private

  def driver_params
    params.require(:driver).permit(:name, :vin)
  end
end
