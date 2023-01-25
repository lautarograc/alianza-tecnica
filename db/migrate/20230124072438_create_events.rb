# frozen_string_literal: true

class CreateEvents < ActiveRecord::Migration[7.0]
  def change
    create_table :events do |t|
      t.string :type_is, default: 'Service'
      t.string :service_id
      t.datetime :starts
      t.datetime :ends

      t.timestamps
    end
  end
end
