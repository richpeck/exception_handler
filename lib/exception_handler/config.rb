###########################################

# Refs
# http://stackoverflow.com/questions/10584638/setting-up-configuration-settings-when-writing-a-gem
# http://robots.thoughtbot.com/mygem-configure-block

###########################################

module ExceptionHandler
	class Config
  		mattr_accessor :db, :email, :table, :social, :layouts

  		# Defaults
  		# Merged with Rails options with @@config in engine
		def self.defaults
			{
				db:   	false, #-> defaults to :errors if true, else use :table_name
				email: 	false, #-> need to integrate
				social: {
				    :facebook 	=> 	'frontline.utilities',
				    :twitter 	=> 	'frontlineutils',
				    :youtube 	=>	'frontlineutils',
				    :linkedin 	=> 	'frontline-utilities',
				    :fusion 	=> 	'frontlineutils',
				    :url => {
					    :facebook 	=> 	'https://facebook.com',
					    :twitter 	=> 	'http://twitter.com',
					    :youtube 	=>	'https://youtube.com/user',
					    :linkedin 	=> 	'https://linkedin.com/company',
					    :fusion 	=> 	'https://frontlinefusion.com',				    	
				    },
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
