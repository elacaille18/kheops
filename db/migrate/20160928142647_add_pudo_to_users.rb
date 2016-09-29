class AddPudoToUsers < ActiveRecord::Migration
  def change
    add_column :users, :pudo, :boolean
    add_column :users, :pudo_long, :string
    add_column :users, :pudo_lat, :string
    add_column :users, :pudo_city, :string
  end
end
