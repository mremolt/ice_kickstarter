send_notifications_to({
  :infopark => "falk.koeppe@infopark.de",
})

buckets 'kickstarter' do
  bucket('spec:integration').performs_rake_tasks 'spec:integration'
end