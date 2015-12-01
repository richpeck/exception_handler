module ExceptionHandler
	module ApplicationHelper

		#Refs
		#http://stackoverflow.com/a/5795683/1143732
		#http://stackoverflow.com/questions/8028021/helpers-in-rails-engine
		#ActiveSupport.on_load( :action_view ){ include ExceptionHandler::ViewHelpers }

		#Social
		def social *args
			output = []
			# options = args.extract_options! http://simonecarletti.com/blog/2009/09/inside-ruby-on-rails-extract_options-from-arrays/ - args for arrays

			services = args.any? ? args : ExceptionHandler.config[:social]
			services.each do |key,value|
    			output.push link_to(image_tag("exception_handler/connect/#{key}.png", title: "Find us on " + key.to_s.titleize), link(key), target: :blank, class: key.to_s)
    		end

    		output.join("").html_safe #-> ruby returns last line
		end

		private

		def link service #-> bloated way to allow single references in config
			url = ExceptionHandler.config[:social][service]
			url[1] = ExceptionHandler.social[service] if !url[1]
			url.reverse!.join("/")
		end

	end
end