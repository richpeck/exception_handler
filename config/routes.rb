########################################
########################################
##    _____            _              ##
##   | ___ \          | |             ##
##   | |_/ /___  _   _| |_ ___  ___   ##
##   |    // _ \| | | | __/ _ \/ __|  ##
##   | |\ \ (_) | |_| | ||  __/\__ \  ##
##   \_| \_\___/ \__,_|\__\___||___/  ##
##                                    ##
########################################
########################################

## Good resource
## https://gist.github.com/maxivak/5d428ade54828836e6b6#merge-engine-and-app-routes

########################################
########################################

## Routes ##
Rails.application.routes.draw do

  ########################################
  ########################################

    # => ExceptionHandler
    # => Used to provide error page examples in "dev" mode
    if Object.const_defined?("ExceptionHandler") && ExceptionHandler.config.try(:dev)

      # => Items
      Rack::Utils::HTTP_STATUS_CODES.select{ |key, value| key.to_s.match('\b(?:4[0-9]{2}|5[0-9]{2}|599)\b') }.each do |status,code|
        get status.to_s, to: 'exception_handler/exceptions#show', as: code.underscore.gsub(' ', '_'), code: code.underscore.gsub(' ', '_')
      end

    end

  ########################################
  ########################################

end

########################################
########################################
