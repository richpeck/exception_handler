###########################################

# Refs
# http://stackoverflow.com/questions/10584638/setting-up-configuration-settings-when-writing-a-gem
# http://robots.thoughtbot.com/mygem-configure-block

###########################################

module ExceptionHandler
  class Config

    #Instace Objects
    attr_accessor :dev, :db, :email, :social, :layouts

    ###########################################
    ###########################################

      # Table Name
      # Has to be "errors" because "exceptions" is a reserved word
      TABLE = :errors

      # Defaults
      # http://stackoverflow.com/a/8917301/1143732
      DEFAULTS = {
        dev:    false, #-> defaults to "false" for dev mode
        db:     false, #-> defaults to :errors if true, else use "table_name" / :table_name
        email: 	false, #-> requires string email and ActionMailer
        social: {
          facebook: { name: "frontline.utilities", url: "https://facebook.com" },
          twitter:  { name: "frontlineutils",      url: "http://twitter.com" },
          youtube:  { name: "frontlineutils",      url: "https://youtube.com/user" },
          linkedin: { name: "frontline-utilities", url: "https://linkedin.com/company" },
          fusion:   { name: "flutils",             url: "https://frontlinefusion.com" }
        },
        layouts: {
          "400" => nil, # => inherits from "ApplicationController" layout
          "500" => "exception"
        },
      }

    ###########################################
    ###########################################

      #Init
      def initialize values
        # => Defaults
        DEFAULTS.deep_merge!(values || {}).each do |k,v|
          instance_variable_set("@#{k}",v)
        end

        # => Errors
        raise(Exception, "ExceptionHandler :: Valid Email Required") if @email && !@email.is_a? String
        #raise(Exception, "ExceptionHandler :: Migration Required → Table \"#{db}\" doesn't exist") if @db && !ActiveRecord::Base.connection.table_exists?(db)
      end

    ###########################################
    ###########################################

      def db
        @db == true ? TABLE_NAME : @db
      end

    ###########################################
    ###########################################

  end
end
