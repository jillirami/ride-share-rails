# frozen_string_literal: true

class AddDefaultStatusToDrivers < ActiveRecord::Migration[5.2]
  def change
    change_column(:drivers, :status, :boolean, default: true)
  end
end
