class FixColumnName < ActiveRecord::Migration
  def change
    rename_column :parcels, :description, :sender_first_name
    rename_column :parcels, :user_id, :owner_id
  end
end
