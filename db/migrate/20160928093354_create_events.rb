class CreateEvents < ActiveRecord::Migration
  def change
    create_table :events do |t|
      t.references :user, index: true, foreign_key: true
      t.references :parcel, index: true, foreign_key: true
      t.string :type

      t.timestamps null: false
    end
  end
end
