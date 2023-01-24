class AddEventsReferenceToAliada < ActiveRecord::Migration[7.0]
  def change
    add_reference :events, :aliada, foreign_key: true
  end
end
