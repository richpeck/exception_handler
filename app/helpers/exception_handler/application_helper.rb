module ExceptionHandler
	module ApplicationHelper

		#Refs
		#http://stackoverflow.com/a/5795683/1143732
		#http://stackoverflow.com/questions/8028021/helpers-in-rails-engine
		#ActiveSupport.on_load( :action_view ){ include ExceptionHandler::ViewHelpers }

		#Social
		def social *services
			output = []
			# options = args.extract_options! http://simonecarletti.com/blog/2009/09/inside-ruby-on-rails-extract_options-from-arrays/ - args for hash

			services = ExceptionHandler.config.social unless services.any? #-> http://api.rubyonrails.org/classes/Hash.html#method-i-compact
			services.except(:url).compact.each do |service,username| #-> except http://stackoverflow.com/a/11105831/1143732
    			output.push link_to(image_tag("exception_handler/connect/#{service}.png", title: "Find us on " + service.to_s.titleize), link(service), target: :blank, class: service.to_s)
    		end

    		output.join("").html_safe #-> ruby returns last line
		end

		private

		def link service #-> bloated way to allow single references in config
			url = []
			url.push ExceptionHandler.config.social[:url][service]
			url.push ExceptionHandler.config.social[service]
			url.join("/")
		end

	end
end