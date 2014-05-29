###########################################
# Refs
# http://stackoverflow.com/questions/10584638/setting-up-configuration-settings-when-writing-a-gem
# http://robots.thoughtbot.com/mygem-configure-block
###########################################
module ExceptionHandler
  class Config
    attr_accessor :db

    def initialize
      @db = false # -> db name (false = no; true = "errors"; [value] = [value])
    end
  end
end