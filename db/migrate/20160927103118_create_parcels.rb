class CreateParcels < ActiveRecord::Migration
  def change
    create_table :parcels do |t|
      t.string :description
      t.string :code
      t.references :user, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
