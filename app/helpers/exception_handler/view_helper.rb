module ExceptionHandler
	module ViewHelper

  	##################

    #App
    def app
      Rails.application.class.parent_name
    end

    #Details
    #Ref - https://gist.github.com/wojtha/8433843#file-ruby-rb-L29
    def details
      @details ||= {}.tap do |h|
        I18n.with_options scope: [:exception, :show, @exception.response], message: @exception.message do |i18n|
          h[:name]    = i18n.t "#{@exception.class.name.underscore}.title",       default: i18n.t(:title,       default: @exception.class.name)
          h[:message] = i18n.t "#{@exception.class.name.underscore}.description", default: i18n.t(:description, default: @exception.message)
        end
      end
    end

  	##################

	end
end