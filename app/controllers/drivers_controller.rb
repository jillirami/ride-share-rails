# frozen_string_literal: true

class DriversController < ApplicationController
  def index
    @drivers = Driver.all.order(:id)
  end

  def show
    driver_id = params[:id]
    @driver = Driver.find_by(id: driver_id)
    head :not_found if @driver.nil?
  end

  def new
    @driver = Driver.new
  end
end
