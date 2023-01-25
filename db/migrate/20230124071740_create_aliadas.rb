# frozen_string_literal: true

class CreateAliadas < ActiveRecord::Migration[7.0]
  def change
    create_table :aliadas do |t|
      t.string :name

      t.timestamps
    end
  end
end
