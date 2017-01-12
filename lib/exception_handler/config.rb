###########################################

# Refs
# http://stackoverflow.com/questions/10584638/setting-up-configuration-settings-when-writing-a-gem
# http://robots.thoughtbot.com/mygem-configure-block

###########################################

module ExceptionHandler
  class Config

    # => Instace Objects
    # => ExceptionHandler.config.dev
    # => ExceptionHandler.config.db
    # => ExceptionHandler.config.email
    # => ExceptionHandler.config.social
    # => ExceptionHandler.config.layouts
    # => ExceptionHandler.config.custom_exceptions
    attr_accessor :dev, :db, :email, :social, :layouts, :custom_exceptions

    ###########################################
    ###########################################
    ###########################################
    ###########################################

      # => Table Name
      # => Has to be "errors" because "exceptions" is a reserved word
      TABLE = :errors

      # => Social URLs
      # => Extracted from "social" block
      SOCIAL = {
        facebook: "https://facebook.com",
        twitter:  "https://twitter.com",
        youtube:  "https://youtube.com/user",
        linkedin: "https://linkedin.com/company",
        fusion:   "https://frontlinefusion.com"
      }

    ###########################################
    ###########################################

      # => Defaults
      # => http://stackoverflow.com/a/8917301/1143732
      DEFAULTS = {
        dev:    nil, # => defaults to "false" for dev mode
        db:     nil, # => defaults to :errors if true, else use "table_name" / :table_name
        email: 	nil, # => requires string email and ActionMailer
        social: {
          facebook: nil,
          twitter:  nil,
          youtube:  nil,
          linkedin: nil,
          fusion:   nil,
        },
        layouts: {
          # => nil inherits from ApplicationController
          # => 4xx errors should be nil
          # => 5xx errors should be "exception" but can be nil if explicitly defined
          500 => "exception",
          501 => "exception",
          502 => "exception",
          503 => "exception",
          504 => "exception",
          505 => "exception",
          507 => "exception",
          510 => "exception"
        }
      }

    ###########################################
    ###########################################

      # => Init
      # => Merges DEFAULTS to values, creates instances vars (for attr_accessor)
      def initialize values
        # => Vars
        DEFAULTS.deep_merge!(values || {}).each do |k,v|
          instance_variable_set("@#{k}",v)
        end

        # => Validation
        raise ExceptionHandler::Error, "Email Not Valid" if @email && !@email.nil? && !@email.is_a?(String)
        raise ExceptionHandler::Error, "Migration Required → Table \"#{db}\" doesn't exist" if @db && !ActiveRecord::Base.connection.table_exists?(db)
      end

    ###########################################
    ###########################################

      # => DB
      # => If config db = "true", use TABLE constant
      def db
        @db == true ? TABLE : @db.try(:parameterize, separator: "_")
      end

    ###########################################
    ###########################################
    ###########################################
    ###########################################

  end
end
