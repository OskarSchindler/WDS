set :environment, "development"
set :output, {:error => "log/cron_error_log.log", :standard => "log/cron_log.log"}

every 5.minutes do
  rake "schedulejobs:daily"
end


