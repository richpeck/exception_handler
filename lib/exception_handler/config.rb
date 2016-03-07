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

      #Init
      def initialize values=nil
        defaults = values.present? ? Config::DEFAULTS.deep_merge!(values) : Config::DEFAULTS
        defaults.each do |k,v|
          instance_variable_set("@#{k}",v) #-> http://apidock.com/ruby/Object/instance_variable_set	
        end
      end

      # INSTANCE METHODS #

      #DB
      def db
        @db == true ? Config::TABLE_NAME : @db
      end

    ###########################################

      #Default Table Name
      # Has to be "errors" because "exceptions" is a reserved word
      TABLE_NAME = :errors

      # Defaults
      # http://stackoverflow.com/a/8917301/1143732
      DEFAULTS = {
        dev: 	  false, #-> defaults to "false" for dev mode
        db:     false, #-> defaults to :errors if true, else use :table_name
        email: 	false, #-> need to integrate
        social: {
          :facebook 	=> 	'frontline.utilities',
          :twitter 	  => 	'frontlineutils',
          :youtube 	  =>	'frontlineutils',
          :linkedin 	=> 	'frontline-utilities',
          :fusion 	 => 	'frontlineutils',
          :url => {
            :facebook 	=> 	'https://facebook.com',
            :twitter 	=> 	'http://twitter.com',
            :youtube 	=>	'https://youtube.com/user',
            :linkedin 	=> 	'https://linkedin.com/company',
           :fusion 	=> 	'https://frontlinefusion.com',				    	
          },
        },
        layouts: {
          '404' => nil, #-> 404 Callback (needs improving big time) Use the following: '404' => <<-EOF redirect_to root_url, notice: "Hello" EOF
          '500' => 'exception'
        },
      }

    ###########################################

  end
end