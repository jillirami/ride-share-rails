# frozen_string_literal: true

class ChangeDataTypeOfDriverId < ActiveRecord::Migration[5.2]
  def change
    remove_column(:trips, :driver_id)
    add_reference(:trips, :driver, foreign_key: true)
  end
end
