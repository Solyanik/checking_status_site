namespace :checking_status_site do
  desc 'Start task to checking status site'
  task go: :environment do
  	Rails.application.config.urls.each do |val|
    	Cron::CheckingStatusSite::CheckingStatusSite.new(val, from: Rails.application.config.mailAdressFrom, to: Rails.application.config.mailAdressTo).start
    end
  end
end