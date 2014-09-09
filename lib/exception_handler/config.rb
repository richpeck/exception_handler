###########################################

# Refs
# http://stackoverflow.com/questions/10584638/setting-up-configuration-settings-when-writing-a-gem
# http://robots.thoughtbot.com/mygem-configure-block

###########################################

module ExceptionHandler
  class Config
	attr_accessor :db, :social, :error_layout, :exception_layout

	def initialize
		@db = false # -> db name (false = no; true = "errors"; [value] = [value])
		@social = {
			twitter: 	"http://twitter.com/frontlineutils",
			facebook: 	"https://facebook.com/frontline.utilities",
			linkedin: 	"https://linkedin.com/company/frontline-utilities",
			youtube: 	"https://youtube.com/user/frontlineutils",
			fusion: 	"http://frontlinefusion.com/frontlineutils"
		}
    @error_layout = nil
    @exception_layout = nil
    end
  end
end
