###########################################

# Refs
# http://stackoverflow.com/questions/10584638/setting-up-configuration-settings-when-writing-a-gem
# http://robots.thoughtbot.com/mygem-configure-block

###########################################

module ExceptionHandler
  class Config
  		mattr_accessor :db, :email, :social, :layouts

  		@@social = {
		    :twitter 	=> 	'http://twitter.com',
		    :facebook 	=> 	'https://facebook.com',
		    :linkedin 	=> 	'https://linkedin.com/company',
		    :youtube 	=>	'https://youtube.com/user',
		    :fusion 	=> 	'https://frontlinefusion.com',
		}

  		# Defaults
  		# Merged with Rails options with @@config in engine
		def self.defaults
			{
				db:   	false, #-> defaults to :errors if true, else use :table_name
				email: 	false, #-> need to integrate
				social: {
				    :twitter 	=> 	['frontlineutils', 		@@social[:twitter]],
				    :facebook 	=> 	['frontline.utilities', @@social[:facebook]],
				    :linkedin 	=> 	['frontline-utilities', @@social[:linkedin]],
				    :youtube 	=>	['frontlineutils', 		@@social[:youtube]],
				    :fusion 	=> 	['frontlineutils', 		@@social[:fusion]],
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
