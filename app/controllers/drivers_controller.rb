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
      render :new, status: :bad_request
    end
  end

  def edit
    @driver = Driver.find_by(id: params[:id])

    if @driver.nil?
      redirect_to drivers_path
    end
  end

  def update
    driver = Driver.find_by(id: params[:id])

    if driver.nil?
      redirect_to drivers_path
    else
      is_successful = driver.update(driver_params)
    end

    if is_successful
      redirect_to driver_path(driver.id)
    end
  end

  def destroy
    driver = Driver.find_by(id: params[:id])

    if driver.nil?
      head :not_found
    else
      driver.destroy
      redirect_to drivers_path
    end
  end

  private

  def driver_params
    params.require(:driver).permit(:name, :vin)
  end
end
