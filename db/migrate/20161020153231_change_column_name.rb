class ChangeColumnName < ActiveRecord::Migration
  def change
    rename_column :events, :type, :description
  end
end
