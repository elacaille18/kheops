class AddColumnsToParcels < ActiveRecord::Migration
  def change
    add_column :parcels, :sender_last_name, :string
    add_column :parcels, :sender_phone, :string
    add_column :parcels, :receiver_first_name, :string
    add_column :parcels, :receiver_last_name, :string
    add_column :parcels, :receiver_phone, :string
  end
end
