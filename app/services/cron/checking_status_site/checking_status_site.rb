#Cron::СheckingStatusSite::Checkingstatussite.new.start!

module Cron
	module CheckingStatusSite
		class CheckingStatusSite < ApplicationController

			def initialize(url, **params)

				@url_http = url
				@params = params

			end 

			def start

				get_status(@url_http)

			end

			private

			def get_status(url_http)

				url = URI.parse(url_http)

				response = Net::HTTP.get_response(url)
				
				send_email(response: response, url: url_http)

			end

			def send_email(**data) 

				name = "Сhecking status site (#{ data[:url] })"
				message = "URL: #{ data[:url] }; Response code: #{ data[:response].code }; Message: #{ data[:response].message };"

				id_last = EmailLog.where("name LIKE :search_url", :search_url => "%#{ data[:url] }%").order(:created_at => 'desc').take.try(:id)
				
				type_message = ( data[:response].code.to_i == 200 ? 'successful' : 'error' )
				
				EmailLog.create(name: name, type_message: type_message, message: message) if !EmailLog.where("type_message = :type_message and id = :id_last", 
					:type_message => type_message, :search_url => "%#{ data[:url] }%", :id_last => id_last).exists?
			
				EmailLog.where(status: nil).all.each do |i|

					mail = Mail.new do
						subject  i.name
						body     i.message
					end

					mail[:from] = @params[:from]
					mail[:to] = @params[:to]

				    EmailLog.update(i.id, status: "sent") if mail.deliver!

				end

			end

		end
	end
end