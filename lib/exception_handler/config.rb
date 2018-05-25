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
    # => ExceptionHandler.config.layouts
    # => ExceptionHandler.config.exception
    # => ExceptionHandler.config.custom_exceptions # ??? 
    attr_accessor :dev, :db, :email, :social, :exceptions, :custom_exceptions

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
        
        exceptions: {
          all: {                 # => Defaults for all exceptions. Override with specific status codes
            deliver: true,
            layout: "exception"
          }
        },
        
        # deprecated
        layouts: {
          # => nil inherits from ApplicationController
          # => 4xx errors should be nil
          # => 5xx errors should be "exception" but can be nil if explicitly defined
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
        
        initialize_layouts

        # => Validation
        raise ExceptionHandler::Error, "Email Not Valid" if @email && !@email.nil? && !@email.is_a?(String)
        raise ExceptionHandler::Error, "Migration Required → \"#{db}\" doesn't exist" if @db && !ActiveRecord::Base.connection.table_exists?(db) && (File.basename($0) != "rake" && !ARGV.include?("db:migrate"))
        raise ExceptionHandler::Error, "exceptions option should be a hash" if !@exceptions.is_a?(Hash)
        @exceptions.each do |status, options|
          for key, val in options
            case key
            when :deliver then raise ExceptionHandler::Error, "Status #{status} deliver option (#{val.inspect}) invalid. Expected Boolean or Proc" if !val.is_a?(TrueClass) && !val.is_a?(FalseClass) && !val.is_a?(Proc)
            when :layout  then raise ExceptionHandler::Error, "Status #{status} layout option (#{val.inspect}) invalid. Expected nil, String, or Proc" if !val.is_a?(NilClass) && !val.is_a?(String) && !val.is_a?(Proc)
            end
          end
        end
      end

      # => Migrate deprecated +layouts+ config option to +exceptions+ map
      #
      #    layouts[500] = 'custom_layout' 
      #         => 
      #    exceptions[500] = { 
      #      deliver: true, 
      #      layout: custom_layout
      #    }
      #
      # => These override values from the exceptions map because the `:all` 
      #    key has to be guaranteed to be processed first.
      #
      def initialize_layouts
        for k,v in @layouts
          @exceptions[k] ||= @exceptions[:all].dup
          @exceptions[k][:layout] = v
        end
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
