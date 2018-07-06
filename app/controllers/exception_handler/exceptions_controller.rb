module ExceptionHandler
  class ExceptionsController < ApplicationController

    # => Response
    # => http://www.justinweiss.com/articles/respond-to-without-all-the-pain/
    respond_to :html, :js, :json, :xml

    # => CSRF
    protect_from_forgery

    # => Devise
    # => http://stackoverflow.com/a/38531245/1143732
    skip_before_action :authenticate_user!, raise: false

    ##################################
    ##################################

    # => Definitions
    # => Exception model (tied to DB)
    before_action { |e| @exception = ExceptionHandler::Exception.new request: e.request }
    before_action { @exception.save if @exception.valid? && ExceptionHandler.config.try(:db) }

    # => Response format (required for non-standard formats (.css / .gz etc))
    # => request.format required until responders updates with wildcard / failsafe (:all)
    before_action { |e| e.request.format = :html unless self.class.respond_to.include? e.request.format }

    # => Routes
    # => Removes need for "main_app" prefix in routes
    # => http://stackoverflow.com/a/40251516/1143732
    helper Rails.application.routes.url_helpers

    # => Layout
    # => Layouts only 400 / 500 because they are the only error responses (300 is redirect)
    # => http://guides.rubyonrails.org/layouts_and_rendering.html#the-status-option
    # => Layout proc kills "nil" inheritance, needs to be method for now
    layout :layout

    ####################
    #     Actions      #
    ####################

    # => General Show Functionality
    def show
      respond_with @exception, status: @exception.status
    end

    ##################################
    ##################################

    private

    # => Shows different layouts
    # => New setup takes
    def layout

      # 1) specific
      # 2) all
      # 3) 4xx/5xx

      # => Has to cover older version { "x" }
      # => Has to cover newer version { layout: "x" }
      config = ExceptionHandler.config.layout(@exception.status)

      # => Expected result either STRING or HASH
      # => Indifferent access used for HASH to allow for strings & symbols
      config = ActiveSupport::HashWithIndifferentAccess.new(config).try(:[], :layout) if config.is_a?(Hash)

      # => Return
      # => Should have been config || 'exception'
      # => However, this would have precluded nil responses (which we need)
      # => The present basically just tests for empty strings (which we don't want)
      config == '' ? 'exception' : config

    end

    ##################################
    ##################################

  end
end
