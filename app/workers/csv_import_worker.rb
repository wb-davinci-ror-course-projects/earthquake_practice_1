class CsvImportWorker
  @queue = :csv_import_worker

  def self.perform(file)
    Earthquake.import_csv(file)
  end
end