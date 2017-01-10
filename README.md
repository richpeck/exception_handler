![Exception Handler](readme/title.jpg "Exception Handler Logo")

<p align="center">
  <font size="4"><strong>Custom 404 & 500 production error pages for Rails 4 & 5.</font></strong>
</p>

<p align="center">
  <a href="http://badge.fury.io/rb/exception_handler"><img src="https://badge.fury.io/rb/exception_handler.svg" align="absmiddle"></a>
  <a href="http://rubygems.org/gems/exception_handler"><img src="http://ruby-gem-downloads-badge.herokuapp.com/exception_handler/0.5.1?type=total&color=brightgreen" align="absmiddle" /></a>
  <a href="https://codeclimate.com/github/richpeck/exception_handler"><img src="https://codeclimate.com/github/richpeck/exception_handler/badges/gpa.svg" align="absmiddle"/></a>
  <a href="https://gemnasium.com/richpeck/exception_handler"><img src="https://gemnasium.com/richpeck/exception_handler.svg" align="absmiddle"></a>
  <a href='https://coveralls.io/github/richpeck/exception_handler?branch=master'><img src='https://coveralls.io/repos/github/richpeck/exception_handler/badge.svg?branch=master' alt='Coverage Status' align="absmiddle" /></a>
  <a href="https://travis-ci.org/richpeck/exception_handler"><img src="https://travis-ci.org/richpeck/exception_handler.svg?branch=master" align="absmiddle"></a>
</p>

<p align="center">
  <strong><a href="#install">Install</a></strong> → <strong><a href="#config">Setup</a></strong> → <strong><a href="#support">Support</a></strong>
</p>

---

<p align="center">
  <img src="readme/version.jpg" /><br/>
</p>

<p align="center">
  <img src="readme/check.png" height="22" title="Fully Responsive"               align="absmiddle" />&nbsp; <strong>Responsive</strong> &nbsp;
  <img src="readme/check.png" height="22" title="Branded Error Pages"            align="absmiddle" />&nbsp; <strong>Branded Error Pages</strong> &nbsp;
  <img src="readme/check.png" height="22" title="Middleware Exception Handling"  align="absmiddle" />&nbsp; <strong>Middleware Exception Handling</strong> &nbsp;
  <img src="readme/check.png" height="22" title="Keep Users Informed"            align="absmiddle" />&nbsp; <strong>Fully Customizable</strong> &nbsp;
</p>

<p align="center">
  <img src="readme/branded/1.jpg" width="425" title="Fully Branded Error Pages" /> <img src="readme/branded/2.jpg" width="425" title="Fully Branded Error Pages" />
  <img src="readme/branded/3.jpg" width="425" title="Fully Branded Error Pages" /> <img src="readme/branded/4.jpg" width="425" title="Fully Branded Error Pages" />
</p>

---

<p align="center">
  <img src="readme/05.jpg" title="Version 0.7.0" />
</p>

<p align="center">
  <br />
  <img src="readme/titles/rails5.png" title="Fully Rails 5 Compatible" width="550" />
</p>

<p align="center">
  <img src="readme/check_02.png" height="22" title="New Controller"           align="absmiddle" />&nbsp; <strong align="absmiddle">New Controller</strong> &nbsp;
  <img src="readme/check_02.png" height="22" title="New Middleware"           align="absmiddle" />&nbsp; <strong align="absmiddle">New Middleware</strong> &nbsp;
  <img src="readme/check_02.png" height="22" title="Full Test Suite"          align="absmiddle" />&nbsp; <strong align="absmiddle">Full Test Suite</strong> &nbsp;
  <img src="readme/check_02.png" height="22" title="Rails 4 & 5 Compatible"   align="absmiddle" />&nbsp; <strong align="absmiddle">Fully Rails 4 & 5 Compatible</strong> &nbsp;
</p>

Brand new `controller` & `middleware` have made **`ExceptionHandler`** even more powerful & efficient. Now you can use `ExceptionHandler` with a [single click](#install) → **plug and play** custom exception pages:

<p align="center">
  <br />
  <img src="readme/400.png" title="400 Errors" width="430" />
  <img src="readme/500.png" title="500 Errors" width="430" />
</p>

<p align="center">For over 3 years, <strong>ExceptionHandler</strong> has provided production-level <strong>Rails</strong> exception handling for <strong>4xx</strong> and <strong>5xx</strong> errors:</p>

[[ stuff ]]

Since browsers only read `4xx` & `5xx` error codes, any exceptions raised by Rails have to be interpolated. Thus, `ExceptionHandler` simply has to manage how the `4xx` / `5xx` errors are passed to the browser.

Unlike other gems, **`ExceptionHandler` uses a custom [`controller`](app/controllers/exception_handler/exceptions_controller.rb) to build an [`@exception`](app/models/exception_handler/exception.rb) object**. This allows us to save the exception, email it or do anything else we may need. The gem has already been a massive success and we continue to actively maintain it.

Now, at version [`0.7.5`](https://github.com/richpeck/exception_handler/releases/tag/0.7.5), we invite you to try for yourself ...


----

<p align="center">
  <br />
  <img src="readme/titles/middleware.png" title="Middleware-Powered Exceptions" width="400" />
</p>

The secret lies in [**`config.exceptions_app`**][exception_app] ↴

![Exceptions handled by the ActiveDispatch::ShowExceptions Middleware][middleware]

All Rails exceptions are handled with the `config.exceptions_app` callback. This is assigned in `config/application.rb` or `config/environments/*.rb`:

![config.exceptions_app][config.exceptions_app]

Each time Rails raises an exception, the [`ShowExceptions`][show_exception] middleware takes the request and forwards it to `config.exceptions_app`. This hook is expected to return a response - this is where we can inject our own callback (in our case a [`controller`](app/controllers/exception_handler/exceptions_controller.rb)):

![config.exceptions_app - The key to all Rails exceptions][exceptions_app]

Because our callback parses the erroneous request, we are able to do whatever we need before serving a response. This is a major advantage over the "default" way of handling `Rails` exceptions (routes). This invokes Rails twice and does not persist the request (exception lost).

 `ExceptionHandler` is the **only** gem to provide middleware-powered exception handling.  It populates our custom `view` with any details required, giving us the ability to **maintain branding** when exceptions are raised:

![Exceptions handled by the ActiveDispatch::ShowExceptions Middleware][middleware]

**This makes `ExceptionHandler` the MOST EFFECTIVE and EFFICIENT gem to handle exceptions in Rails**. Once invoked, its `model`, `controller` and `views` work together to serve the most efficient responses to Rails errors.

<p align="center">
  <strong>The <i>ONLY</i> professional solution to manage Rails exceptions WITHOUT BLOAT:</strong>
</p>

<p align="center">
  <img src="readme/controller_middleware.jpg" title="ExceptionsController compiles the exception & delivers to the front-end" />
</p>

Even better, you can install `ExceptionHandler` (plug and play) with a single click:

----------

<p align="center" id="install">
  <br />
  <img src="readme/titles/install.png" title="1 Click Install for ExceptionHandler 0.7.0 on Rails 5" width="400" />
  <br />
  <strong>Installing the gem is <i>simple</i> - ZERO configuration required:</strong>
  <br />
</p>

[![Gemfile][gemfile]][rubygems] [![Gem][gem]][rubygems]


<p align="center">
  <a href="#config">Config</a> → <a href="#dev-mode">Dev Mode</a> → <a href="#database">Database</a> → <a href="#email">Email</a> → <a href="#view">View</a> → <a href="#locales">Locales</a> → <a href="#custom-exceptions">Custom Exceptions</a>
</p>

----

## Config

From [`0.4.7`](https://github.com/richpeck/exception_handler/releases/tag/0.4.6), **`ExceptionHandler`** manages its config from the central Rails config (not an initializer):

[[ config ]]

This gives us unprecedented flexibility - environment-driven development etc.

Config options are as follows:

    #config/application.rb
    ...
    config.exception_handler = {
      dev:    false, # => set to "true" for dev mode
      db:     false, # => defaults to :errors if true, else use "table_name" / :table_name
      email: 	false, # => requires string email and ActionMailer
      social: {
        facebook: nil, # => this has changed from previous versions (it is now just the username)
        twitter:  nil,
        youtube:  nil,
        linkedin: nil,
        fusion:   nil,
      },
      layouts: {
        400 => nil, # => inherits from "ApplicationController" layout
        500 => "exception"
      }
    }

This allows us to change

----

## Dev Mode

By default, `ExceptionHandler` only works in production.

If you want to enable it to work in dev,

----

## Database

The `Exception` model creates the `@exception` object for us.

---

## Email

---

## View

---

## Locales

`0.7.5` introduced flexible locales.

By default, `ExceptionHandler`

---

## Layout

The `layout` has been improved dramatically:

[[ layout screenshot ]]

You can now assign layouts to the *status code* of the response:

[[ status codes ]]

By default, `5xx` errors are shown with our [`exception` layout][layout] - this can be overridden by changing the `config` to use a layout of your choice. If you want to inherit the `ApplicationController` layout, set the various status codes to `nil`.

Our professionally designed `exception` layout has also been improved:

[[ layout ]]

Now the *majority* of design is handled with the CSS.

---


## Custom Exceptions

Due to popular demand, we investigated how to add **custom exceptions**.

Turns out the functionality is *already* built into Rails [`config.action_dispatch.rescue_responses`][rescue_responses] ↴

![ActionDispatch][config.action_dispatch.rescue_responses]

Because the browser can only read `4xx` or `5xx` HTTP errors, any exception raised inside Rails needs to be interpolated. This is handled by the `action_dispatch.rescue_responses` middleware.

Specifically, you have to register your custom exception against an [HTTP response code][status_codes]. This is done as follows:

    #config/application.rb
    config.action_dispatch.rescue_responses["ActionController::YourError"] = :bad_request

The full list of Rails HTTP response codes can be found [here][status_codes]. The default is `bad_request` / `500`.

We have built this functionality into `ExceptionHandler` --

    # config/application.rb
    config.exception_handler = {
      custom_exceptions = {
        "ActionController::MyError" => :bad_request
      }
    }

This just recreates the declarations in our gem, so may remove it. We figured if you're raising custom exceptions, you may wish to keep them with `ExceptionHandler`'s config, rather than separate.

---

## Support

stackoverflow
github issues

---

## Changelog

### [0.7.5](https://github.com/richpeck/exception_handler/releases/tag/0.7.5)
 - [ ] HTTP code layouts
 - [ ] Custom exception mapping

### [0.7.0](https://github.com/richpeck/exception_handler/releases/tag/0.7.0)
 - [x] Wildcard mime types
 - [x] [Custom exceptions](#custom_exceptions)
 - [x] Test suite integration
 - [x] [Email](#email)
 - [x] [Model backend](#database)
 - [x] Sprockets 4+
 - [x] New layout
 - [x] Readme / wiki overhaul

### [0.6.5](https://github.com/richpeck/exception_handler/releases/tag/0.6.5)
 - [x] Streamlined interface
 - [x] ActiveRecord / Middleware overhaul
 - [x] Supports Sprockets 4+ ([`manifest.js`](http://eileencodes.com/posts/the-sprockets-4-manifest/))
 - [x] Email integration
 - [x] Asset overhaul & improvement
 - [x] Removed dependencies

### [0.5.0](https://github.com/richpeck/exception_handler/releases/tag/0.5.0)
 - [x] Locales
 - [x] Email notifications
 - [x] Full test suite
 - [x] Rails 4.2 & Rails 5.0 native ([`request.env`](https://github.com/rails/rails/commit/05934d24aff62d66fc62621aa38dae6456e276be) fix)
 - [x] Controller fixed
 - [x] `DB` fixed
 - [x] Legacy initializer support ([more](https://github.com/richpeck/exception_handler/wiki/1-Setup))
 - [x] Rails asset management improvement
 - [x] Reduced gem file size

### [0.4.7](https://github.com/richpeck/exception_handler/releases/tag/0.4.6)
 - [x] New config system
 - [x] Fixed controller layout issues
 - [x] Streamlined middleware
 - [x] New layout & interface implementation

----------
![404 + 500 Errors][banner]

<p align="center">
  <strong><a href="#">ExceptionHandler</a> is now the leading custom error pages gem for Rails.</strong>
  <br />
  No other gem is as simple or effective at providing beautiful exception pages in production.
</p>

----------

:copyright: <a href="http://www.frontlineutilities.co.uk" align="absmiddle" ><img src="readme/fl.jpg" height="22" align="absmiddle" /></a> <a href="http://stackoverflow.com/users/1143732/richard-peck?tab=profile" align="absmiddle" ><img src="https://avatars0.githubusercontent.com/u/1104431" height="22" align="absmiddle" /></a>

<!-- ################################### -->
<!-- ################################### -->

<!-- Refs -->
<!-- Comments http://stackoverflow.com/a/20885980/1143732 -->
<!-- Images   https://github.com/adam-p/markdown-here/wiki/Markdown-Cheatsheet#images -->

<!-- Images -->
[config.action_dispatch.rescue_responses]: readme/config.action_dispatch.rescue_responses.jpg
[banner]:           readme/banner.png
[config.exceptions_app]: readme/config.exceptions_app.jpg
[gem]:              readme/gem.jpg
[gemfile]:          readme/gemfile.jpg
[middleware]:       readme/middleware.jpg
[exceptions_app]:   readme/exceptions_app.jpg
[view]:             readme/titles/view.jpg
[dev]:              readme/titles/dev.jpg
[db]:               readme/titles/db.png
[support]:          readme/titles/support.png "Support"
[changelog]:        readme/titles/changelog.png "Changelog"
[contribution]:     readme/titles/contributions.png "Contributions"
[fl]:               readme/fl.jpg "Frontline Utilities LTD"
[profile]:          https://avatars0.githubusercontent.com/u/1104431 "R Peck"

<!-- Links -->
[layout]: app/views/layouts/exception.html.erb
[status_codes]: http://guides.rubyonrails.org/layouts_and_rendering.html#the-status-option
[stackoverflow]: http://stackoverflow.com/questions/ask?tags=ruby-on-rails+exception-handler
[rescue_responses]: http://guides.rubyonrails.org/configuring.html#config.action_dispatch.rescue_responses
[latest]: https://github.com/richpeck/exception_handler/releases/latest
[show_exception]: https://github.com/rails/rails/blob/4-0-stable/actionpack/lib/action_dispatch/middleware/show_exceptions.rb
[exception_app]: http://guides.rubyonrails.org/configuring.html#rails-general-configuration
[rubygems]: http://rubygems.org/gems/exception_handler
[frontlineutilities.co.uk]: http://www.frontlineutilities.co.uk
[stackoverflow.com]: http://stackoverflow.com/users/1143732/richard-peck?tab=profile
[fork]: #fork-destination-box
[pull]:  http://github.com/richpeck/exception_handler/pulls

<!-- ################################### -->
<!-- ################################### -->
