# Use this file to easily define all of your cron jobs.
#
# It's helpful, but not entirely necessary to understand cron before proceeding.
# http://en.wikipedia.org/wiki/Cron

# Example:
#
# set :output, "/path/to/my/cron_log.log"
#
# every 2.hours do
#   command "/usr/bin/some_great_command"
#   runner "MyModel.some_method"
#   rake "some:great:rake:task"
# end
#
# every 4.days do
#   runner "AnotherModel.prune_old_records"
# end

# Learn more: http://github.com/javan/whenever

# whenever --update-crontab store

#set :environment, ENV['RAILS_ENV']
#set :bundle_command, ""
#set :output, "log/cron_log.log"

every 1.minute do
	rake 'checking_status_site:go', output: 'log/checking_status_site_cron.log'
end
