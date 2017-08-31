namespace :checking_status_site do
  desc 'Start task to checking status site'
  task go: :environment do
  	["https://pokupon.ua", "https://partner.pokupon.ua"].each do |val|
    	Cron::CheckingStatusSite::CheckingStatusSite.new(val, from: "info@test.info", to: "obslpk@yandex.ru").start
    end
  end
end