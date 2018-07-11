########################################################################################
########################################################################################
##   _____                   _   _               _   _                 _ _            ##
##  |  ___|                 | | (_)             | | | |               | | |           ##
##  | |____  _____ ___ _ __ | |_ _  ___  _ __   | |_| | __ _ _ __   __| | | ___ _ __  ##
##  |  __\ \/ / __/ _ \ '_ \| __| |/ _ \| '_ \  |  _  |/ _` | '_ \ / _` | |/ _ \ '__| ##
##  | |___>  < (_|  __/ |_) | |_| | (_) | | | | | | | | (_| | | | | (_| | |  __/ |    ##
##  \____/_/\_\___\___| .__/ \__|_|\___/|_| |_| \_| |_/\__,_|_| |_|\__,_|_|\___|_|    ##
##                   | |                                                              ##
##                   |_|                                                              ##
########################################################################################
########################################################################################

module ExceptionHandler

  ##############################
  ##############################

    # => Table Prefix
    # => Keeps Rails Engine from generating all table prefixes with the engines name
    # => http://stackoverflow.com/questions/19435214/rails-mountable-engine-with-isolate-namespace-but-without-prefixed-namespace-on
    def self.table_name_prefix
      # => No prefix
    end

    # => Config
    # => Invoke instance of config (ExceptionHandler.config)
    mattr_accessor :config

  ##############################
  ##############################

    # => Exceptions
    # => https://github.com/thoughtbot/paperclip/blob/master/lib/paperclip/errors.rb
    class Error < StandardError; end

  ##############################
  ##############################


end

#########################################################
#########################################################

# => Libs
# => http://stackoverflow.com/a/4528011/1143732
# => http://stackoverflow.com/a/21693468/1143732
# => https://github.com/jekyll/jekyll/blob/master/lib/jekyll.rb#L8
Dir.glob(File.join(File.dirname(__FILE__), 'exception_handler', '**/*.rb'), &method(:require))

# => External Dependencies
require 'responders'

#########################################################
#########################################################
