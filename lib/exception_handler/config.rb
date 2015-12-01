###########################################

# Refs
# http://stackoverflow.com/questions/10584638/setting-up-configuration-settings-when-writing-a-gem
# http://robots.thoughtbot.com/mygem-configure-block

###########################################

module ExceptionHandler

	# Accessible throughout the module
	# http://stackoverflow.com/a/7853148/1143732
	def self.social
		@@social ||= {
		    :twitter 	=> 	'http://twitter.com',
		    :facebook 	=> 	'https://facebook.com',
		    :linkedin 	=> 	'https://linkedin.com/company',
		    :youtube 	=>	'https://youtube.com/user',
		    :fusion 	=> 	'https://frontlinefusion.com',
		}
	end

	class Config
  		mattr_accessor :db, :email, :social, :layouts

  		# Defaults
  		# Merged with Rails options with @@config in engine
		def self.defaults
			{
				db:   	false, #-> defaults to :errors if true, else use :table_name
				email: 	false, #-> need to integrate
				social: {
				    :twitter 	=> 	['frontlineutils', 		ExceptionHandler.social[:twitter]],
				    :facebook 	=> 	['frontline.utilities', ExceptionHandler.social[:facebook]],
				    :linkedin 	=> 	['frontline-utilities', ExceptionHandler.social[:linkedin]],
				    :youtube 	=>	['frontlineutils', 		ExceptionHandler.social[:youtube]],
				    :fusion 	=> 	['frontlineutils', 		ExceptionHandler.social[:fusion]],
				},
				layouts: {
				    '400' => nil,
				    '500' => 'exception'
				},
			}
		end

		#404 Callback (needs improving big time)
		#Use the following:

		#'404' => <<-EOF
        #    redirect_to root_url, notice: "Hello"
        #EOF

        #This will invoke specifics for the 
	end
end
