class AddColumnToParcel < ActiveRecord::Migration
  def change
    add_column :parcels, :code, :string
  end
end
