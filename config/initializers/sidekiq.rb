require "sidekiq"
require "sidekiq-cron"

schedule_file = "config/schedule.yml"

if File.exist?(schedule_file) && Sidekiq.server?
  Sidekiq::Cron::Job.load_from_hash YAML.load_file(schedule_file)
end

Sidekiq.configure_server do |config|
  config.redis = { url: "redis://localhost:6379/0" } # URL de Redis para el servidor
end

Sidekiq.configure_client do |config|
  config.redis = { url: "redis://localhost:6379/0" } # URL de Redis para el cliente
end
