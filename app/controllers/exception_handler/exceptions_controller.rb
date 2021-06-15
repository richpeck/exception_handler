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
    before_action do |e|
      verify_requested_format!
    rescue
      e.request.format = :html
    end

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
    # => Introduced new "action" config option in 0.8.0.0
    def show
      respond_with @exception, status: @exception.status
    end

    ##################################
    ##################################

    private

    # => Pulls from Exception class
    # => Spanner in the works is nil
    # => .present? validates against empty strings (IE a string is present)
    # => .nil? validates to see if the returned data is "nil"
    # => nil required to facilitate inheritance of the layout w/ ApplicationController
    def layout option = ExceptionHandler.config.options(@exception.status, :layout)
      (option.present? || option.nil?) ? option : 'exception'
    end

    ##################################
    ##################################

  end
end
