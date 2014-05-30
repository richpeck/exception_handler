# [![Exception Handler](https://raw.githubusercontent.com/richpeck/exception_handler/master/readme/exception_handler.png "Exception Handler Logo")](http://frontlineutilities.co.uk/ruby-on-rails/exception-handler)

[![Gem Version](https://badge.fury.io/rb/exception_handler.svg)](http://badge.fury.io/rb/exception_handler)
[![Code Climate](https://codeclimate.com/github/richpeck/exception_handler.png)](https://codeclimate.com/github/richpeck/exception_handler)
[![Dependency Status](https://gemnasium.com/richpeck/exception_handler.svg)](https://gemnasium.com/richpeck/exception_handler)
[![Coverage Status](https://coveralls.io/repos/richpeck/exception_handler/badge.png)](https://coveralls.io/r/richpeck/exception_handler)
[![Build Status](https://travis-ci.org/richpeck/exception_handler.svg?branch=master)](https://travis-ci.org/richpeck/exception_handler)


[**ExceptionHandler** Rails Gem](https://rubygems.org/gems/exception_handler) (adapted from [this tutorial](https://gist.github.com/wojtha/8433843) & our own middleware)

Works with the [`config.exceptions_app`](http://guides.rubyonrails.org/configuring.html#rails-general-configuration) hook in Rails' middleware stack:

    config.exceptions_app sets the exceptions application invoked by the ShowExceptionmiddleware
    when an exception happens. Defaults to ActionDispatch::PublicExceptions.new(Rails.public_path).

-----------

####Custom Error Pages

You can create *custom error pages*. These allow you to serve your own design error pages in production; showing both the error, and the problem. This is a big step forward from the standard Rails error reporting facility



####Save Errors To DB

Sometimes, you want to save your errors to your database (admin areas, multi-tenant apps, etc). We've included some middleware which captures the routes 

---------

## Installation

Add this line to your application's Gemfile:

    gem 'exception_handler'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install exception_handler

###Generators

	# General
	$ rails generate exception_handler:install

	#Config (for db)
	$ rails generate exception_handler:config

	#Assets
	$ rails generate exception_handler:assets:all
	-
	$ rails generate exception_handler:assets:views
	$ rails generate exception_handler:assets:controllers
	$ rails generate exception_handler:assets:models
	$ rails generate exception_handler:assets:assets



---------

## Usage

###Dev

	#config/environments/development.rb
	config.consider_all_requests_local = false # true

`config.exceptions_app` is used in Rails' production environment. Therefore, if you wish to test the gem in dev,
you'll need to make your app process requests as `production` for now. This is a temporary step, and will be
resolved in a new version

###Production

    No action required

###Demo

Demo to be put onto Heroku etc

--------

## Support

If you need help, you may consider:

1. Watching this [**video tutorial**](http://www.youtube.com/watch?v=Zo2vav3dYnY):

   [![ExceptionHandler Update](http://img.youtube.com/vi/Zo2vav3dYnY/0.jpg)](http://www.youtube.com/watch?v=Zo2vav3dYnY)
2. Read [**our tutorial**](http://google.com)
3. Ask on [**StackOverflow**](http://stackoverflow.com)
4. Go on the [**gem support page**](http://frontlineutilities.co.uk)

---------

## Contributing

1. Fork it ( https://github.com/richpeck/exception_handler/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
