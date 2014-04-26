class CreateEarthquakes < ActiveRecord::Migration
  def change
    create_table :earthquakes do |t|
      t.datetime :time
      t.decimal :latitude, precision: 9, scale: 4
      t.decimal :longitude, precision: 9, scale: 4
      t.decimal :depth
      t.string :mag
      t.string :magtype
      t.string :nst
      t.string :gap
      t.string :dmin
      t.string :rms
      t.string :net
      t.string :usgs_ident
      t.string :updated
      t.string :place
      t.string :event_type

      t.timestamps
    end
  end
end
