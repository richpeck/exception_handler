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
  <img src="readme/rails.jpg" title="Version 0.7.5 Released Early 2017" />
</p>

<p align="center">
  <img src="readme/titles/rails5.png" title="Fully Rails 5 Compatible" width="600" />
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

![HTTP Error Codes][http_codes]

Since browsers only read `4xx` & `5xx` error codes, any exceptions raised by Rails have to be inferred. Thus, `ExceptionHandler` simply has to manage how the `4xx` / `5xx` errors are passed to the browser.

Unlike other gems, **`ExceptionHandler` uses a custom [`controller`](app/controllers/exception_handler/exceptions_controller.rb) to build an [`@exception`](app/models/exception_handler/exception.rb) object**. This allows us to save the exception, email it or do anything else we may need. The gem has already been a massive success and we continue to actively maintain it.

Now you can try for yourself...


----

<p align="center">
  <br />
  <img src="readme/titles/middleware.png" title="Middleware-Powered Exceptions" width="400" />
</p>

The secret lies in [**`config.exceptions_app`**][exception_app] ↴

![Exceptions handled by the ActiveDispatch::ShowExceptions Middleware][middleware]

All Rails exceptions are handled by `config.exceptions_app`:

> **`config.exceptions_app`** sets the exceptions application invoked by the **`ShowException`** middleware when an exception happens. Defaults to **`ActionDispatch::PublicExceptions.new(Rails.public_path)`**

Each time an exception is raised, [`ShowExceptions`][show_exception] takes the request and forwards it to `config.exceptions_app`. This is expected to return a response - allowing us to inject a [`controller`](app/controllers/exception_handler/exceptions_controller.rb):

> ```app.config.exceptions_app = ->(env) { ExceptionHandler::ExceptionsController.action(:show).call(env) }```

![config.exceptions_app - The key to all Rails exceptions][exceptions_app]

Because *our* callback handles the entire request, we are able to do whatever we need before serving a response. This is a **major** advantage over the "default" (routes). The routes invokes Rails twice and does not persist the request.

 **`ExceptionHandler` is the only gem to provide middleware-powered exception handling.**  It populates our custom `view` with details, giving us the ability to **maintain branding** when exceptions are raised:

![Exceptions handled by the ActiveDispatch::ShowExceptions Middleware][middleware]

**`ExceptionHandler` is the most EFFECTIVE and EFFICIENT gem to handle exceptions in Rails**.

Once invoked, its `model`, `controller` and `views` work together to serve the best responses to Rails errors ...

----------

<p align="center" id="install">
  <br />
  <img src="readme/titles/install.png" title="1 Click Install for ExceptionHandler 0.7.0 on Rails 5" width="400" />
  <br />
  <strong>Custom Rails Error Pages - ZERO configuration needed:</strong>
  <br />
</p>

<p align="center">
  <a href="http://rubygems.org/gems/exception_handler"><img src="readme/gem.jpg" /></a> <a href="http://rubygems.org/gems/exception_handler"><img src="readme/gemfile.jpg" /></a>
</p>


<p align="center">
  You can install it from the <strong>CLI</strong> or <strong>Gemfile</strong> - it will AUTOMATICALLY run in <strong>production</strong>.
  <br />
  <strong>↓ To run in development, use <a href="#dev-mode">dev mode</a> ↓</strong>
</p>

---

<p align="center">
  If you want to set up `ExceptionHandler` to run your way, there are features to make it run correctly...
</p>

<p align="center">
  <a href="#config"><img src="readme/titles/icons/config.png" alt="Cinfiguration Options" align="absmiddle" /> Config</a>&nbsp;&nbsp;&nbsp;&nbsp;<a href="#dev-mode" title="Dev Mode"><img src="readme/titles/icons/dev.png" alt="Dev" align="absmiddle" /> Dev</a>&nbsp;&nbsp;&nbsp;&nbsp;<a href="#database"><img src="readme/titles/icons/database.png" alt="Database" align="absmiddle" />  Database</a>&nbsp;&nbsp;&nbsp;&nbsp;<a href="#email"><img src="readme/titles/icons/email.png" alt="Email" align="absmiddle" />  Email</a>&nbsp;&nbsp;&nbsp;&nbsp;<a href="#views"><img src="readme/titles/icons/views.png" alt="Views" align="absmiddle" />  Views</a>&nbsp;&nbsp;&nbsp;&nbsp;<a href="#locales"><img src="readme/titles/icons/locales.png" alt="Locales" align="absmiddle" />  Locales</a>&nbsp;&nbsp;&nbsp;&nbsp;<a href="#custom-exceptions"><img src="readme/titles/icons/custom.png" alt="Custom Exceptions" align="absmiddle" />  Custom Exceptions</a>&nbsp;&nbsp;&nbsp;&nbsp;<a href="#generators"><img src="readme/titles/icons/generators.png" alt="Generators" align="absmiddle" />  Generators</a>
</p>

----

## Config

**From [`0.4.7`](https://github.com/richpeck/exception_handler/releases/tag/0.4.6), `ExceptionHandler` manages its config from the central Rails `config` hash:**

[[ config ]]

[Options](https://github.com/richpeck/exception_handler/blob/master/lib/exception_handler/config.rb#L45) are as follows:

    #config/application.rb
    ...
    config.exception_handler = {
      dev:    false, # => set to "true" for dev mode
      db:     false, # => defaults to :errors if true, else use "table_name" / :table_name
      email:  false, # => requires string email and ActionMailer
      social: {
        facebook: nil, # => this has changed from previous versions (it is now just the username)
        twitter:  nil,
        youtube:  nil,
        linkedin: nil,
        fusion:   nil,
      },
      layouts: {
        # => nil inherits from ApplicationController
        # => 4xx errors default to nil
        # => 5xx errors should be "exception" but can be nil if explicitly defined
        500 => "exception",
        501 => "exception",
        502 => "exception",
        503 => "exception",
        504 => "exception",
        505 => "exception",
        507 => "exception",
        510 => "exception"
      }
    }

If you're using a [`Rails` Engine](http://guides.rubyonrails.org/engines.html), you **don't** need to include it in an `initializer`:

    # lib/engine.rb
    module YourModule
      class Engine < Rails::Engine

        # => ExceptionHandler
        # => Works in and out of an initializer
        config.exception_handler = {
          dev:    false,
          db:     false,
          email: 	false,
          social: {
            facebook: nil,
            twitter:  nil,
            youtube:  nil,
            linkedin: nil,
            fusion:   nil,
          },
          layouts: {
            # => nil inherits from ApplicationController
            # => 4xx default to nil
            # => 5xx errors should be "exception" but can be nil if explicitly defined
            500 => "exception",
            501 => "exception",
            502 => "exception",
            503 => "exception",
            504 => "exception",
            505 => "exception",
            507 => "exception",
            510 => "exception"
          }
        }
      end

    end

**The above config is *default*.** You **only** need to provide the inputs you want, for example:

    # config/application.rb
    config.exception_handler = { dev: true }

    # config/environments/production.rb
    config.exception_handler = {
      social: {
        fusion: "flutils"
      }
    }

----

## Dev Mode

**By default, `ExceptionHandler` only works in production ...**

If you want to enable it in dev, enable the [`dev`](lib/exception_handler/config.rb#L38) option:

    # config/application.rb
    config.exception_handler = { dev: true }

This disables [`config.consider_all_requests_local`](http://guides.rubyonrails.org/configuring.html#rails-general-configuration), making Rails behave as it would in production. This gives you the ability to edit the exception flow, either creating your own interface or ensuring it works correctly:

[[ dev mode ]]

----

## Database

**We also have `ActiveRecord` integration.**

If you want to save your exceptions to `db`, you need to enable the `db` config option:

    # config/application.rb
    config.exception_handler = {
      db: true
    }

This enables `ActiveRecord::Base` on the [`Exception`](app/models/exception_handler/exception.rb) class, allowing us to save to the database.

In order for this to work, you need the correct table in your db.

To do this, once you've enabled the option, run `rails db:migrate` from your console. Our new [`migration system`](https://github.com/richpeck/exception_handler/tree/readme#migrations) will automatically run the migration.

---

## Email

**`ExceptionHandler` now sends email notifications**:

If you want to receive emails whenever your application raises an error, you can do so by adding your email to the config:

    # config/application.rb
    config.exception_handler = {
      email: "your@email.com",
    }

> **Please Note** this requires [`ActionMailer`](http://guides.rubyonrails.org/action_mailer_basics.html). If you don't have any outbound SMTP server, sign up to [`SendGrid`](http://sendgrid.com) for free.

See the [**full tutorial** here](https://github.com/richpeck/exception_handler/wiki/2-Email)

---

## Views

**From [`0.7.0`](#070), we drastically overhauled the view system:**

[[ View ]]

The [view](app/views/exception_handler/exceptions/show.html.erb) is now *modular* - we pass the `@exception` object and populate with the [`locales`](#locales).

The view is very simple:

    <%= content_tag :div, class: "exception" do %>
      <%= content_tag :span, @exception.description.html_safe %>
    <% end %>

Each time `ExceptionHandler` returns a response, it invokes this view. The difference lies in the `layout` -- `5xx` errors use our `exception` layout by default.

---

## Locales

**[`0.7.5`](https://github.com/richpeck/exception_handler/releases/tag/0.7.5) introduced locales ...**

[[ locales ]]

The `ExceptionHandler` view is populated by `@exception.description`, which pulls from the `locales`.

By default, only the `404` and `500` locales are defined:

[[ locales ]]

If you want custom messages, you need to create the following:

    # config/locales/en.yml
    en:
      exception_handler:
        not_found: "Your locale here"
        internal_server_error: "This is a test to show the %{status} of the error"

You also get access to `%{message}` and `%{status}`, both inferring data from the `@exception` object.

Each locale should use the `status_symbol` as described [here](https://github.com/rack/rack/blob/1.5.2/lib/rack/utils.rb#L544).

---

## Layout

**The `layout` has also been improved ↴**

[[ layout screenshot ]]

We now assign layouts to the **status code** of the response:

[[ status codes ]]

By default, `5xx` errors are shown with our [`exception` layout][layout] - this can be overridden by changing the `config` to use a layout of your choice. If you want to inherit the `ApplicationController` layout, assign the codes to `nil`.

[[ layout ]]

The *majority* our `layout` is handled with the CSS. This allows the view to be completely modular:

[[ CSS ]]

---


## Custom Exceptions

**Custom Exceptions also supported in [`0.7.5`](https://github.com/richpeck/exception_handler/releases/tag/0.7.5)**

Rails handles this for us - [**`config.action_dispatch.rescue_responses`**][rescue_responses]  ↴

![ActionDispatch][config.action_dispatch.rescue_responses]

    # config/application.rb
    config.action_dispatch.rescue_responses["ActionController::YourError"] = :bad_request

Works by taking a hash of exceptions and matching them to [`status codes`](https://github.com/rack/rack/blob/1.5.2/lib/rack/utils.rb#L544)

All standard exceptions are covered. If you wish to add a custom exception, you need to add to the hash.

Because `HTTP` can only process `4xx` / `5xx` errors, if `Rails` raises an exception, it needs to assign one of the error status codes. **Default** is [`internal_server_error`](https://github.com/rack/rack/blob/1.5.2/lib/rack/utils.rb#L595) - if you'd prefer your app to just return `500` errors for your custom exception, you don't need to explicitly declare them.

---

## Generators

**You can generate `ExceptionHandler` into your own application:**

[[ Generator ]]

You can use the following commands...

    rails g exception_handler:views
    rails g exception_handler:views -v views
    rails g exception_handler:views -v controllers
    rails g exception_handler:views -v models
    rails g exception_handler:views -v assets
    rails g exception_handler:views -v views controllers models assets

If you don't include any switches, this will copy **all** the folders put into your app.

Each switch defines which folders you want (EG `-v views` will only copy `views` directory).

---

### Migrations (deprecated)

**From [`0.7.5`](https://github.com/richpeck/exception_handler/releases/tag/0.7.5), the `migration` generator has been removed in favour of our own [migration system](lib/exception_handler/engine.rb#L58).**

You don't need to generate a migration any more.

If you set the `db` option in config, run `rails db:migrate` and the migration will be run.

To rollback, use the following:

    rails db:migrate:down VERSION=000000

> The drawback to this is that if you remove the `ExceptionHandler` gem before you rollback the migration, it won't exist anymore.

> You can **only** fire the above command when you have `ExceptionHandler` installed.

---

## Support

Just ask in our [Github issues](https://github.com/richpeck/exception_handler/issues) :smile:

---

## Changelog

### [0.7.5](https://github.com/richpeck/exception_handler/releases/tag/0.7.5)
 - [x] [HTTP status layouts](#layouts)

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
 - [x] New layout & interface

----

[![404 + 500 Errors][banner]][rubygems]

<p align="center">
  <strong><a href="#">ExceptionHandler</a> is now the leading custom error pages gem for Rails.</strong>
  <br />
  No other gem is as simple or effective at providing beautiful exception pages in production.
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
  <strong><a href="https://rubygems.org/gems/exception_handler">Download Here</a></strong>
</p>

----------

:copyright: <a href="http://www.frontlineutilities.co.uk" align="absmiddle" ><img src="readme/fl.jpg" height="22" align="absmiddle" /></a> <a href="http://stackoverflow.com/users/1143732/richard-peck?tab=profile" align="absmiddle" ><img src="https://avatars0.githubusercontent.com/u/1104431" height="22" align="absmiddle" /></a>

<!-- ################################### -->
<!-- ################################### -->

<!-- Refs -->
<!-- Comments http://stackoverflow.com/a/20885980/1143732 -->
<!-- Images   https://github.com/adam-p/markdown-here/wiki/Markdown-Cheatsheet#images -->

<!-- Images -->
[http_codes]:       readme/http_codes.png
[config.action_dispatch.rescue_responses]: readme/config.action_dispatch.rescue_responses.jpg
[banner]:           readme/banner.jpg
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
[better_errors]: https://github.com/charliesome/better_errors
[layout]: app/views/layouts/exception.html.erb
[status_codes]: http://guides.rubyonrails.org/layouts_and_rendering.html#the-status-option
[stackoverflow]: http://stackoverflow.com/questions/ask?tags=ruby-on-rails+exception-handler
[rescue_responses]: http://guides.rubyonrails.org/configuring.html#configuring-action-dispatch
[latest]: https://github.com/richpeck/exception_handler/releases/latest
[show_exception]: https://github.com/rails/rails/blob/4-0-stable/actionpack/lib/action_dispatch/middleware/show_exceptions.rb
[exception_app]: http://guides.rubyonrails.org/configuring.html#rails-general-configuration
[rubygems]: http://rubygems.org/gems/exception_handler
[frontlineutilities.co.uk]: http://www.frontlineutilities.co.uk
[stackoverflow.com]: http://stackoverflow.com/users/1143732/richard-peck?tab=profile
[fork]: #fork-destination-box
[pull]:  http://github.com/richpeck/exception_handler/pulls
[issues]: http://github.com/richpeck/exception_handler/issues

<!-- ################################### -->
<!-- ################################### -->
