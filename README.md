# [![Exception Handler](https://raw.githubusercontent.com/richpeck/exception_handler/master/readme/title.png "Exception Handler Logo")](http://frontlineutilities.co.uk/ruby-on-rails/exception-handler)

[![Gem Version](https://badge.fury.io/rb/exception_handler.svg)](http://badge.fury.io/rb/exception_handler)
[![Code Climate](https://codeclimate.com/github/richpeck/exception_handler.png)](https://codeclimate.com/github/richpeck/exception_handler)
[![Dependency Status](https://gemnasium.com/richpeck/exception_handler.svg)](https://gemnasium.com/richpeck/exception_handler)
[![Coverage Status](https://coveralls.io/repos/richpeck/exception_handler/badge.png)](https://coveralls.io/r/richpeck/exception_handler)
[![Build Status](https://travis-ci.org/richpeck/exception_handler.svg?branch=master)](https://travis-ci.org/richpeck/exception_handler)


[**ExceptionHandler** Rails Gem](https://rubygems.org/gems/exception_handler) (adapted from [this tutorial](https://gist.github.com/wojtha/8433843) & [this tutorial](http://www.sharagoz.com/posts/1-rolling-your-own-exception-handler-in-rails-3))

Works with the [`config.exceptions_app`](http://guides.rubyonrails.org/configuring.html#rails-general-configuration) hook in Rails' middleware stack:

    config.exceptions_app sets the exceptions application invoked by the ShowExceptionmiddleware
    when an exception happens. Defaults to ActionDispatch::PublicExceptions.new(Rails.public_path).

-----------

####Custom Error Pages

`ExceptionHandler` deploys *custom error pages*. These allow you to serve your own design error pages in production; showing both the error, and the problem. This is a big step forward from the standard Rails error reporting facility

There are two types of error page: 

	- 404 errors
	- 500 errors (+ other)

The custom **`404`** error uses your own `layout`. The **`500 & other errors`** are `server` issues, and so we have included an `errors` layout (`/views/layouts/errors.html.erb`).

The `errors` layout in important. If you try and load your "standard" layout with an internal server error, all your
"supporting" functionality is called too. Problem? You're likely going to cause even more errors.

**Custom error pages** are included by default.
You can change them by using the **`rails generate exception_handler:views`**:

 **500 Errors** | **404 Errors**
--- | ---
![500 Server Error Pages](https://raw.githubusercontent.com/richpeck/exception_handler/master/readme/500.png "500 Server Error Page") | ![404 Server Error Pages](https://raw.githubusercontent.com/richpeck/exception_handler/master/readme/404.png "404 Server Error Page") 
Uses **errors** layout | Uses **standard** layout

-----------

####Saving Errors To DB

Adapted & refactored from [this tutorial](http://www.sharagoz.com/posts/1-rolling-your-own-exception-handler-in-rails-3)

Sometimes, you want to save your errors to your database (admin areas, multi-tenant apps, etc). We've included some middleware which captures the exceptions & saves them to the db:

	- Model (class) Name
	- Error Message
	- Stack trace
	- Target URL
	- Referrer URL
	- Params
	- User Agent (Browser Details)

This db allows you to track, read & repair errors in your application on the fly. We deploy this in our admin areas, to help us
appreciate any issues on our client apps.

![Errors Table](https://raw.githubusercontent.com/richpeck/exception_handler/master/readme/db.png "Errors Table")

This functionality is **`disabled`** by default

To enable, you need to do the following:

	- rails generate exception_handler:install #-> will install config initializer
	- rails generate exception_handler:migration #-> will create migration (for `errors` table)
	- rake db:migrate #-> creates `errors` table

	- config/initializers/exception_handler.rb
	- ExceptionHandler.setup do |config|
	-    config.db = true
	- end

---------

## Installation

###Step1 

You need to reference the [`exception_handler`](http://rubygems.org/gems/exception_handler) gem. Once you have downloaded the gem, you'll be able to deploy it in your application.

Add this line to your application's Gemfile:

	gem 'exception_handler'

And then execute:

    $ bundle

**Or** install it yourself as:

    $ gem install exception_handler

![gem install](https://raw.githubusercontent.com/richpeck/exception_handler/master/readme/gem_install.png "gem install")

--

###Step2

Run:

	rails generate exception_handler:install

![Installation](https://raw.githubusercontent.com/richpeck/exception_handler/master/readme/install.png "Installation")

This will create `config/initializers/exception_handler.rb`. Whilst not vital, it will give you 
access to the configuration options which can change the gem's behavior:

![Config File](https://raw.githubusercontent.com/richpeck/exception_handler/master/readme/config.png "Configuration")

--

###Database

If you want to set up the database, you will need to use the `migration installer`:

	$ rails generate exception_handler:migration

This creates:

	$ rake db:migrate

This will migrate the datatable for you. Now you need to change `config.db = true`

![DB Config](https://raw.githubusercontent.com/richpeck/exception_handler/master/readme/config_db.png "Config DB")


---------

###Configuration

[Exception handler](https://rubygems.org/gems/exception_handler) comes with 3 installers

**You only need to use `rails generate exception_handler:install`**. The others allow you to include files on your system, or create the `errors` table.

	# General
	$ rails generate exception_handler:install #-> installs "config" file (initializer)

![Install](https://raw.githubusercontent.com/richpeck/exception_handler/master/readme/install.png "Standard Install")


	# Migration
	$ rails generate exception_handler:migration #-> generates migration for "errors" table

![Migration Install](https://raw.githubusercontent.com/richpeck/exception_handler/master/readme/install_migration.png "Migration Install")


	# Files
	$ rails generate exception_handler:views #-> controller, models, views & assets
	$ rails generate exception_handler:views -v views controllers models assets #-> remove as appropriate to install individual assets

![Views Install](https://raw.githubusercontent.com/richpeck/exception_handler/master/readme/install_views.png "Views Install")



---------

## Usage

###Development Environment

**[`config.exceptions_app`](http://guides.rubyonrails.org/configuring.html#rails-general-configuration)** is only used in Rails' production environment. Therefore, if you wish to **test the gem in dev**,
you'll need to make your app process requests as `production` for now. This is a temporary step, and will be
resolved in a new version:

	#config/environments/development.rb
	config.consider_all_requests_local = false # true

![Development Testing](https://raw.githubusercontent.com/richpeck/exception_handler/master/readme/development.png "Development Testing")

You should change this setting if you wish to test your styling in development mode. Please note **it should be temporary**

--

###Production Environment

    No action required

---------

###Demo

**404 Error** | **500 Error**
:---: | :---:
[![404 Error Page](https://raw.githubusercontent.com/richpeck/exception_handler/master/readme/404_demo.png "404 Error Page Demo")](http://firststopcosmeticshop.co.uk/sdfsdf/sdf/sdfsdf) | [![500 Error Page](https://raw.githubusercontent.com/richpeck/exception_handler/master/readme/500_demo.png "500 Error Page Demo")](http://firststopcosmeticshop.co.uk/search/fasdfasdfasdfasdfasdf)
[Link](http://firststopcosmeticshop.co.uk/sdfsdf/sdf/sdfsdf) | [Link](http://firststopcosmeticshop.co.uk/search/fasdfasdfasdfasdfasdf)


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
