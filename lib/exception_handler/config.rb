###########################################
###########################################
##     _____              __ _           ##
##    /  __ \            / _(_)          ##
##    | /  \/ ___  _ __ | |_ _  __ _     ##
##    | |    / _ \| '_ \|  _| |/ _` |    ##
##    | \__/\ (_) | | | | | | | (_| |    ##
##    \____/\___/|_| |_|_| |_|\__,  |    ##
##                             __/  |    ##
##                             |___/     ##
###########################################
###########################################

# Refs
# http://stackoverflow.com/questions/10584638/setting-up-configuration-settings-when-writing-a-gem
# http://robots.thoughtbot.com/mygem-configure-block

###########################################
###########################################

module ExceptionHandler
  class Config

    # => Instace Objects
    # => ExceptionHandler.config.dev
    # => ExceptionHandler.config.db
    # => ExceptionHandler.config.email
    # => ExceptionHandler.config.social
    # => ExceptionHandler.config.layouts -> will need to be deprecated
    # => ExceptionHandler.config.exceptions
    # => ExceptionHandler.config.custom_exceptions
    attr_accessor :dev, :db, :email, :social, :layouts, :exceptions, :custom_exceptions

    ###########################################
    ###########################################
    ###########################################
    ###########################################

      # => Table Name
      # => Has to be "errors" because "exceptions" is a reserved word
      TABLE = :errors

    ###########################################
    ###########################################

      # => Social URLs
      # => Extracted from "social" block
      SOCIAL =
        ActiveSupport::HashWithIndifferentAccess.new({
          facebook: "https://www.facebook.com",
          twitter:  "https://www.twitter.com",
          youtube:  "https://www.youtube.com/user",
          linkedin: "https://www.linkedin.com/company",
          fusion:   "https://www.frontlinefusion.com"
        })

    ###########################################
    ###########################################

      # => Defaults
      # => http://stackoverflow.com/a/8917301/1143732
      DEFAULTS =
        ActiveSupport::HashWithIndifferentAccess.new({

          # => General options
          dev:    nil, # => defaults to "false" for dev mode
          db:     nil, # => defaults to :errors if true, else use "table_name" / :table_name
          email: 	nil, # => requires string email and ActionMailer

          # => Used in "exception" layout
          social: {
            facebook: nil,
            twitter:  nil,
            youtube:  nil,
            linkedin: nil,
            fusion:   nil,
          },

          # => Defaults for exceptions. Override with specific status codes
          # => Please note these are all STRINGS
          exceptions: {

            # => 4xx/5xx base standard
            # => :all provide block customization (overrides 4xx/5xx)
            # => specific provides individual (overrides all)

            # => 4xx Errors (resource not found)
            # => https://en.wikipedia.org/wiki/List_of_HTTP_status_codes#4xx_Client_errors
            '4xx' => {
              layout: nil
              #notification: true #(this is for emails - it's true by default - only if you have email inputted)
              # deliver: ____, (this is general)
              # background: (can define custom background for exceptions layout if required)
            },

            # => 5xx Errors (server error)
            # => https://en.wikipedia.org/wiki/List_of_HTTP_status_codes#5xx_Server_errors
            '5xx' => {
              layout: 'exception'
              # notification: true (this is for emails - it's true by default - only if you have email inputted)
              # deliver: _____, (this is general)
              # background: (can define custom background for exceptions layout if required)
            }

          },

          # Deprecated
          #layouts: {
            # => nil inherits from ApplicationController
            # => 4xx errors should be nil
            # => 5xx errors should be "exception" but can be nil if explicitly defined
            #500 => 'exception',
            #501 => 'exception',
            #502 => 'exception',
            #503 => 'exception',
            #504 => 'exception',
            #505 => 'exception',
            #507 => 'exception',
            #510 => 'exception'
          #},

          # => If you want to map your own classes to HTTP errors
          # => use this...
          custom_exceptions: {
            #'ActionController::RoutingError' => :not_found # => example
          }

        })

    ###########################################
    ###########################################

      # => Cnstructor
      # => Merges DEFAULTS to values, creates instances vars (for attr_accessor)
      def initialize values

        # => Vars
        DEFAULTS.deep_merge!(values || {}).each do |k,v|
          instance_variable_set("@#{k}",v)
        end

        # => Validation
        raise ExceptionHandler::Error, "Email Not Valid" if @email && !@email.nil? && !@email.is_a?(String)
        raise ExceptionHandler::Error, "Migration Required → \"#{db}\" doesn't exist" if @db && !ActiveRecord::Base.connection.table_exists?(db) && (File.basename($0) != "rake" && !ARGV.include?("db:migrate"))

      end

    ###########################################
    ###########################################

      # => DB
      # => If config db = "true", use TABLE constant
      def db
        @db == true ? TABLE : @db.try(:parameterize, separator: "_")
      end

      # => Layout
      # => Requires argument
      def layout status
        ExceptionHandler.config.try(:layouts).try(   :[], status) ||
        ExceptionHandler.config.try(:layouts).try(   :[], status.to_s) ||
        ExceptionHandler.config.try(:exceptions).try(:[], status) ||
        ExceptionHandler.config.try(:exceptions).try(:[], status.to_s) ||
        ExceptionHandler.config.try(:exceptions).try(:[], 'all') ||
        ExceptionHandler.config.try(:exceptions).try(:[], status.to_s.first + 'xx')
      end

    ###########################################
    ###########################################
    ###########################################
    ###########################################

  end
end
