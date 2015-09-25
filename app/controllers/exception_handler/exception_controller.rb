module ExceptionHandler
  class ExceptionController < ApplicationController

    #Response
    respond_to :html, :xml, :json

  	#Dependencies
  	before_action :status, :app_details

    #Layout
    layout :layout_status

    ####################
    #      Action      #
    ####################

  	#Show
    def show
      @layout = self.send(:_layout)
      @message = @status == 404 ? "Sorry, this page is missing" : details[:message]
      render status: @status
    end

    ####################
    #   Dependencies   #
    ####################

    protected

    #Info
    def status
      @exception  = env['action_dispatch.exception']
      @status     = ActionDispatch::ExceptionWrapper.new(env, @exception).status_code
      @response   = ActionDispatch::ExceptionWrapper.rescue_responses[@exception.class.name]
    end

    #Format
    def details
      @details ||= {}.tap do |h|
        I18n.with_options scope: [:exception, :show, @response], exception_name: @exception.class.name, exception_message: @exception.message do |i18n|
          h[:name]    = i18n.t "#{@exception.class.name.underscore}.title", default: i18n.t(:title, default: @exception.class.name)
          h[:message] = i18n.t "#{@exception.class.name.underscore}.description", default: i18n.t(:description, default: @exception.message)
        end
      end
    end
    helper_method :details

    ####################
    #      Layout      #
    ####################

    private

    #Layout
    def layout_status
      case  @status
        when 404
          ExceptionHandler.config.error_layout || nil #-> inherits ApplicationController layout
        else
          ExceptionHandler.config.exception_layout || 'error'
      end     
    end

    #App
    def app_details
      @app_name = Rails.application.class.parent_name
    end

  end
end
