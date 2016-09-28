class AddUsersToParcels < ActiveRecord::Migration
  def change
    add_reference :parcels, :origin, references: :users, index: true
    add_foreign_key :parcels, :users, column: :origin_id
    add_reference :parcels, :destination, references: :users, index: true
    add_foreign_key :parcels, :users, column: :destination_id
  end
end
