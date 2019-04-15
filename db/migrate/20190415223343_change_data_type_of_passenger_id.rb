# frozen_string_literal: true

class ChangeDataTypeOfPassengerId < ActiveRecord::Migration[5.2]
  def change
    remove_column(:trips, :passenger_id)
    add_reference(:trips, :passenger, foreign_key: true)
  end
end
