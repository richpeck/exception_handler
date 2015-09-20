#################################################################################################
##                                                                                             ##
##      ______                     __  _                __  __                ____             ##
##     / ____/  __________  ____  / /_(_)___  ____     / / / /___ _____  ____/ / /__  _____    ##
##    / __/ | |/_/ ___/ _ \/ __ \/ __/ / __ \/ __ \   / /_/ / __ `/ __ \/ __  / / _ \/ ___/    ##
##   / /____>  </ /__/  __/ /_/ / /_/ / /_/ / / / /  / __  / /_/ / / / / /_/ / /  __/ /        ##
##  /_____/_/|_|\___/\___/ .___/\__/_/\____/_/ /_/  /_/ /_/\__,_/_/ /_/\__,_/_/\___/_/         ##
##                      /_/                                                                    ##
##                                                                                             ##
#################################################################################################
# You can add different settings using this file                                                #
# Use the docs at http://github.com/richpeck/exception_handler for info                         #
#################################################################################################

# config/initializers/exception_handler.rb
ExceptionHandler.setup do |config|

  # DB -
  # false / true / :table_name (must exist)
  config.db = false

  # Exception Layout (for 500 errors, defaults to Error)
  # false / name (str or sym)
  #config.exception_layout = :your_name

  # Error Layout (for 400 errors, defaults to Application)
  # false / name (str or sym)
  #config.error_layout = :your_name

  # Email -
  # false / true
  # config.email =

  # Social
  config.social = {
    twitter: 'http://twitter.com/frontlineutils',
    facebook: 'https://facebook.com/frontline.utilities',
    linkedin: 'https://linkedin.com/company/frontline-utilities',
    youtube: 'https://youtube.com/user/frontlineutils',
    fusion: 'http://frontlinefusion.com/frontlineutils'
  }

end