![Exception Handler](/readme/title.jpg "Exception Handler Logo")

<p align="center">
  <a href="http://badge.fury.io/rb/exception_handler"><img src="https://badge.fury.io/rb/exception_handler.svg"></a>
  <a href="https://codeclimate.com/github/richpeck/exception_handler"><img src="https://codeclimate.com/github/richpeck/exception_handler.png"></a>
  <a href="https://gemnasium.com/richpeck/exception_handler"><img src="https://gemnasium.com/richpeck/exception_handler.svg"></a>
  <a href="https://coveralls.io/r/richpeck/exception_handler"><img src="https://coveralls.io/repos/richpeck/exception_handler/badge.png"></a>
  <a href="https://travis-ci.org/richpeck/exception_handler"><img src="https://travis-ci.org/richpeck/exception_handler.svg?branch=master"></a>
</p>

----------

**ExceptionHandler** helps you can create custom **404 & 500 production error pages** *(adapted from [**1**](https://gist.github.com/wojtha/8433843) & [**2**](http://www.sharagoz.com/posts/1-rolling-your-own-exception-handler-in-rails-3))*:

![Exceptions_App middleware](/readme/subtitle.jpg)

<p align="center">
  <img src="/readme/titles/custom_error_pages.png" title="Exceptions_App middleware" />
</p>

---

**ExceptionHandler** uses the `config.exceptions_app` to catch errors & send them to our [`exceptions` controller](app/controllers/exception_handler/exception_controller.rb). It then dissects data such as the `message`, `details`, `user agent`, etc, redirect the user to a `custom view`, storing it in the db:

**40x Errors** | **50x Errors**
--- | ---
![404 Error Page](/readme/400.jpg "404 Error Page (Uses Application Layout)") | ![500 Error Page](/readme/500.jpg "500 Error Page (Uses Error Layout)") 
**layouts/application.html.erb** | **layouts/errors.html.erb** 


All exceptions in Rails are handled by the [**`ActiveDispatch::ShowExceptions`**](https://github.com/rails/rails/blob/4-0-stable/actionpack/lib/action_dispatch/middleware/show_exceptions.rb) middleware. 

This is invoked through a hook called **`config.exceptions_app`**, accessed through the `environment` files of rails `application.rb`, `environments/development.rb`, `environments/production.rb` etc.

Simply, it gives you a concise, robust way to access all the data of an exception, pushing your app to the next level in branding and usability:

![Parse](/readme/parser.jpg "Parser")

----------

<img src="/readme/titles/contents.png" title="Contents" />

- [**Installation**](https://github.com/richpeck/exception_handler#installation)
  - [Config](https://github.com/richpeck/exception_handler#config)
  - [DB](https://github.com/richpeck/exception_handler#db)
  - [Views](https://github.com/richpeck/exception_handler#views)
  - [Layout](https://github.com/richpeck/exception_handler#layout)
- [**Development**](https://github.com/richpeck/exception_handler#development)
- [**Bugs**](https://github.com/richpeck/exception_handler#bugs)

----------

## Installation

     gem install 'exception_handler'
 
or 

    gem 'exception_handler', '~> 0.4.6' # Gemfile

You can see [`ExceptionHandler` on RubyGems](https://rubygems.org/gems/exception_handler)

`ExceptionHandler` works out of the box.

You only need to change the appropriate `config` option in `config/application.rb` or `config/production.rb` *if* you want any specific changes.

----------

##### Config

If you wish to change any of the default settings (below), you can now add `config.exception_handler` to your `config/application.rb` or `config/production.rb` file:

![Config Options](/readme/config.jpg)


**IMPORTANT**

If you're upgrading to `0.4.6`, you need to remove your `exception_handler` initializer.

We've changed the load process to use Rails app `config` - **you don't need the `exception_handler` initializer any more**

----------

##### DB

If you want to store exceptions in the db, you will need to set up a `migration`:

    $ rails generate exception_handler:migration
    $ rake db:migrate

![Database](/readme/db.jpg "Database")

You will also need to ensure your config `db` option is either `true` || `:table_name`:

![Database Edit](/readme/db_edit.jpg "Database Edit")

----------

##### Views

If you want to change the views, you can have them put into your app:

    $ rails generate exception_handler:views #-> controller, models, helpers, views & assets
	  $ rails generate exception_handler:views -v views controllers models helpers assets #-> remove as appropriate to install individual assets

The views will be appended to your app, and you'll be able to edit them as required.

---

###### Show

![View](/readme/view.jpg "View")

The view is located in `app/views/exception_handler/show.html.erb` designed to work for all exceptions.

By default, it is split for use with different layouts, data being available to both.

This works exactly the same as the other views in your app (IE the `exceptions` controller invokes the `show` action)

----------

###### Layout

One of the most critial aspects of **ExceptionHandler** is the custom `Error` layout.

If you want to change the layout (for 500 error pages), you need to use the following:

![Layout](/readme/layout.jpg "Layout")

----------

### Development

`config.exceptions_app` is only used in Rails' **production** environment.

If you wish to test the gem in dev, you'll need to make your app process requests as production for now. This is a temporary step, and will be resolved in a new version:

![#config/environments/development.rb](/readme/dev.jpg "Developer Testing")

You should change this setting if you wish to test your styling in development mode. It should be temporary (you need to change it back once you have it looking how you like)

### Usable_Type & Usable_ID

----------

## Bugs

1. `ApplicationController`

   ![ApplicationController](/readme/application_controller.jpg "Application Controller")
   
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