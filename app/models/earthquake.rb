class Earthquake < ActiveRecord::Base
  def self.per_page
    10
  end

  def self.import_csv(file)
    CSV.foreach(file.path, headers: true) do |row|
      Earthquake.create(row.to_hash)
    end
    Earthquake.count
  end
end
