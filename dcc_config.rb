send_notifications_to({
  :infopark => "falk.koeppe@infopark.de",
})

buckets 'kickstarter' do
  bucket('test:integration').performs_rake_tasks 'test:integration'
end