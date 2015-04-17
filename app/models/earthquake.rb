class Earthquake < ActiveRecord::Base
  CSV::HeaderConverters[:usgs_headers] = lambda do |field|
    case field
    when 'magType'
      'magtype'
    when 'id'
      'usgs_ident'
    when 'type'
      'event_type'
    else
      field
    end
  end

  def self.per_page
    10
  end

  def self.import_csv(file_name)
    CSV.foreach(file_name, headers: true, :header_converters => :usgs_headers) do |row|
      Earthquake.create(row.to_hash)
    end
    Earthquake.count
  end

  def self.get_latest_quakes
    hourly_earthquake_csv_url = 'http://earthquake.usgs.gov/eathquakes/feed/v1.0/summary/all_hour.csv'
    local_file = Rails.root.join("tmp/all_hour_#{Time.zone.now.hour}.csv")
    open(local_file, 'wb') do |file|
      file << open(hourly_earthquake_csv_url).read
    end
    Earthquake.import_csv(local_file)
  end
end

