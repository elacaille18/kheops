class RenameColParcel < ActiveRecord::Migration
  def change
    rename_column :parcels, :code, :word
  end
end
