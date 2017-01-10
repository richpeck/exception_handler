###########################################

# Refs
# http://stackoverflow.com/questions/10584638/setting-up-configuration-settings-when-writing-a-gem
# http://robots.thoughtbot.com/mygem-configure-block

###########################################

module ExceptionHandler
  class Config

    # => Instace Objects
    attr_accessor :dev, :db, :email, :social, :layouts, :custom_exceptions

    ###########################################
    ###########################################

    # => Table Name
    # => Has to be "errors" because "exceptions" is a reserved word
    TABLE = :errors

    # => Social URLs
    # => Extracted from "social" block
    SOCIAL = {
      facebook: "https://facebook.com",
      twitter:  "http://twitter.com",
      youtube:  "https://youtube.com/user",
      linkedin: "https://linkedin.com/company",
      fusion:   "http://frontlinefusion.com"
    }

    ###########################################
    ###########################################

    # => Defaults
    # => http://stackoverflow.com/a/8917301/1143732
    DEFAULTS = {
      dev:    false, #-> defaults to "false" for dev mode
      db:     false, #-> defaults to :errors if true, else use "table_name" / :table_name
      email: 	false, #-> requires string email and ActionMailer
      social: {
        facebook: nil,
        twitter:  nil,
        youtube:  nil,
        linkedin: nil,
        fusion:   nil,
      },
      layouts: {
        400 => nil, # => inherits from "ApplicationController" layout
        500 => "exception"
      }
    }

    ###########################################
    ###########################################

      # => Init
      def initialize values
        DEFAULTS.deep_merge!(values || {}).each do |k,v|
          instance_variable_set("@#{k}",v)
        end

        raise Exception.new("ExceptionHandler - Email Is Not Valid") if @email && !@email.is_a?(String)
        raise Exception.new("ExceptionHandler - Migration Required → Table \"#{db}\" doesn't exist") if @db && !ActiveRecord::Base.connection.table_exists?(db)
      end

    ###########################################
    ###########################################

      # => DB
      def db
        @db == true ? TABLE : @db
      end

    ###########################################
    ###########################################

  end
end
