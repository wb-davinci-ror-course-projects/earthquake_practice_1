json.array!(@earthquakes) do |earthquake|
  json.extract! earthquake, :id, :time, :latitude, :longitude, :depth, :mag, :magtype, :nst, :gap, :dmin, :rms, :net, :usgs_ident, :updated, :place
  json.url earthquake_url(earthquake, format: :json)
end
