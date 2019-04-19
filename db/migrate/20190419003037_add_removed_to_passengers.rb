# frozen_string_literal: true

class AddRemovedToPassengers < ActiveRecord::Migration[5.2]
  def change
    add_column(:passengers, :removed, :boolean, default: true)
  end
end
