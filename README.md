![Exception Handler](/readme/title.png "Exception Handler Logo")

[![Gem Version](https://badge.fury.io/rb/exception_handler.svg)](http://badge.fury.io/rb/exception_handler)
[![Code Climate](https://codeclimate.com/github/richpeck/exception_handler.png)](https://codeclimate.com/github/richpeck/exception_handler)
[![Dependency Status](https://gemnasium.com/richpeck/exception_handler.svg)](https://gemnasium.com/richpeck/exception_handler)
[![Coverage Status](https://coveralls.io/repos/richpeck/exception_handler/badge.png)](https://coveralls.io/r/richpeck/exception_handler)
[![Build Status](https://travis-ci.org/richpeck/exception_handler.svg?branch=master)](https://travis-ci.org/richpeck/exception_handler)


----------

Sick of the standard Rails error pages?

Need a custom layout to show professional-looking errors in production?

`exception_handler` is exactly what you need!

----------

**ExceptionHandler** provides error handling for Rails 4+ apps *(adapted from [**1**](https://gist.github.com/wojtha/8433843) & [**2**](http://www.sharagoz.com/posts/1-rolling-your-own-exception-handler-in-rails-3))*.

It hooks into the **[`config.exceptions_app`](http://guides.rubyonrails.org/configuring.html#rails-general-configuration)** middleware:

![Exceptions_App middleware](/readme/exceptions_app.png)

With **ExceptionHandler**, you can create custom **404 & 500 production error pages**:

![Exceptions_App middleware](/readme/subtitle.jpg)

---

**ExceptionHandler** catches errors in the middleware hook (`config.exceptions_app`), channeling the users to our [custom `exceptions` controller](blob/master/app/controllers/exception_handler/exception_controller.rb). It then dissects data such as the `message`, `details`, `user agent`, etc, redirect the user to a `custom view`, storing it in the db:

**40x Errors** | **50x Errors**
--- | ---
![404 Error Page](/readme/400.jpg "404 Error Page (Uses Application Layout)") | ![500 Error Page](/readme/500.jpg "500 Error Page (Uses Error Layout)") 
**layouts/application.html.erb** | **layouts/errors.html.erb** 


All exceptions in Rails are handled by the [`ActiveDispatch::ShowExceptions`](https://github.com/rails/rails/blob/4-0-stable/actionpack/lib/action_dispatch/middleware/show_exceptions.rb) middleware. 

This is invoked through a hook called `config.exceptions_app`, accessed through the `environment` files of rails `application.rb`, `environments/development.rb`, `environments/production.rb` etc.

Whilst it's common practice to use `config.exceptions_app = self.routes` to send exceptions to your routes, `ExceptionHandler` hooks directly into the middleware, giving us access to all the data:

![Parse](/readme/parser.jpg "Parser")

----------

## Installation

     gem install 'exception_handler'
 
or 

    gem 'exception_handler', '~> 0.4.0' # Gemfile

    $ bundle

You can see [`ExceptionHandler` on RubyGems](https://rubygems.org/gems/exception_handler)

--

##### Config

*Optional*

If you wish to change any of the default settings (listed below), run the following command:

    $ rails g exception_handler:install

![Creates config/initializers/exception_handler.rb](/readme/config.jpg)

This will deploy a file to `config/initializers/exception_handler.rb`, which you'll be able to edit as required.

You can run `ExceptionHandler` just from the `gem` if you wish.

--

##### DB

*Optional*

If you want to set up database support (IE have exceptions saved to a table), you need to create a migration:

    $ rails generate exception_handler:migration

![Database](/readme/db.jpg "Database")

This is an optional step. If you want to save the data, you will also need to ensure your `config.db` option is correct:

![Database Edit](/readme/db_edit.jpg "Database Edit")

--

##### Views

*Optional*

If you want to change the views, you can have them put into your app:

    $ rails generate exception_handler:views #-> controller, models, views & assets
	$ rails generate exception_handler:views -v views controllers models assets #-> remove as appropriate to install individual assets

The views will be appended to your app, and you'll be able to edit them as required.

---

###### Show

![View](/readme/view.jpg "View")

The view is a single view designed to work for all exceptions.

By default, it is split for use with different layouts, data being available to both.

This works exactly the same as the other views in your app (IE the `exceptions` controller invokes the `show` action)

---

###### Layout

One of the most critial aspects of **ExceptionHandler** is the custom `Error` layout.

If you want to change the layout (for 500 error pages), you need to use the following:

![Layout](/readme/layout.jpg "Layout")

----------

## Usage

###Development

`config.exceptions_app` is only used in Rails' **production** environment.

If you wish to test the gem in dev, you'll need to make your app process requests as production for now. This is a temporary step, and will be resolved in a new version:

![#config/environments/development.rb](/readme/dev.jpg "Developer Testing")

You should change this setting if you wish to test your styling in development mode. It should be temporary (you need to change it back once you have it looking how you like)

### Usable_Type & Usable_ID

----------

## Bugs

1. `ApplicationController`
   
   A significant issue exists in respect to the inheritance of `exceptions_controller`.
   Our current version (`0.4`) inherits from the `ApplicationController`. This causes a problem for many applications.

   If you use any sort of `before_action` callback in your controller, especially to populate variables, this
   will cause untold problems in your `exceptions_controller`. 

   `500` errors are server faults; trying to get the server to call more data will simply not work. It causes
   an exception loop, leading to catastrophic failure.


## Support

 - Watch the video tutorial (soon)
 - [Create an "issue"](https://github.com/richpeck/exception_handler/issues) 
 - Contact support (soon)
 - [Ask on StackOverflow](http://stackoverflow.com/questions/ask?tags=exception_handler&ruby_on_rails) 

## Contribution

1. Fork it ( https://github.com/richpeck/exception_handler/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request