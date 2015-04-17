class CsvDownloadWorker
  @queue = :csv_download_worker

  def self.perform
    Earthquake.get_latest_quakes
    Resque.enqueue_in(30.seconds, CsvDownloadWorker)
  end
end