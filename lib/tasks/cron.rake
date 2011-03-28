namespace :cron do

  # Only run on db01
  task :nightly do
    invoke 'db:backup'
    invoke 'mail:csv'
  end

  # Only run on db01
  task :hourly do
    invoke 'app:publish'
  end

  # Only run on app01
  task :minutely do
    invoke 'app:clearcache:search' if Time.now.min % 5 == 0 # Every 5 min
  end

end


private

def invoke(name)
  Rake::Task[name].invoke
end