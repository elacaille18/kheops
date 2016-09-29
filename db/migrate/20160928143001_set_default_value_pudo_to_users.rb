class SetDefaultValuePudoToUsers < ActiveRecord::Migration
  def change
    change_column_default :users, :pudo, false
  end
end
