![Exception Handler](readme/title.jpg "Exception Handler Logo")

<!-- Intro -->
<div id="intro">
  <h4 align="center"><strong><a href="https://rubygems.org/gems/exception_handler"><code>ExceptionHandler</code></a></strong> is presently the <strong>MOST POPULAR</strong> exceptions gem for <strong><a href="https://medium.com/ruby-on-rails-web-application-development/custom-400-500-error-pages-in-ruby-on-rails-exception-handler-3a04975e4677">CUSTOM Rails error pages</a></strong>...</h4>
  <p align="center">
    With <strong>180,000+ downloads</strong>, it is the *only* gem to provide <strong>custom 400/500 exception pages for Rails 4 + 5</strong>...
  </p>
</div>

<!-- Badges -->
<p align="center">
  <a href="http://badge.fury.io/rb/exception_handler"><img src="https://badge.fury.io/rb/exception_handler.svg" align="absmiddle"></a>
  <a href="http://rubygems.org/gems/exception_handler"><img src="http://ruby-gem-downloads-badge.herokuapp.com/exception_handler/0.5.1?type=total&color=brightgreen" align="absmiddle" /></a>
  <a href="https://codeclimate.com/github/richpeck/exception_handler"><img src="https://codeclimate.com/github/richpeck/exception_handler/badges/gpa.svg" align="absmiddle"/></a>
  <a href='https://coveralls.io/github/richpeck/exception_handler?branch=master'><img src='https://coveralls.io/repos/github/richpeck/exception_handler/badge.svg?branch=master' alt='Coverage Status' align="absmiddle" /></a>
  <a href="https://travis-ci.org/richpeck/exception_handler"><img src="https://travis-ci.org/richpeck/exception_handler.svg?branch=master" align="absmiddle"></a>
</p>

<!-- Examples -->
<p align="center">
  <img src="readme/branded/1.jpg" width="425" title="Fully Branded Error Pages" /> <img src="readme/branded/2.jpg" width="425" title="Fully Branded Error Pages" />
  <img src="readme/branded/3.jpg" width="425" title="Fully Branded Error Pages" /> <img src="readme/branded/4.jpg" width="425" title="Fully Branded Error Pages" />
</p>

<p align="center">
  Following explains how it works
  <br/>If you need further support, please feel free to email <a href="mailto:rpeck@frontlineutilities.co.uk">rpeck@frontlineutilities.co.uk</a>...
</p>

<!-- Navigation -->
<div id="navigation">
  <p align="center"><img src="https://cdn-images-1.medium.com/max/800/1*CKyKxRXLovcrUOB-s8_jCw.png" width="100%" /></p>
  <p align="center">
    <b>⌚️ <a href="#introduction">Introduction</a> ⌚️</b> - <strong>⚠️ <a href="#installation">Installation</a> ⚠️</strong> - <strong>⚙️ <a href="#configuration">Configuration</a> ⚙️</strong> - <strong>☎️ <a href="#support">Support</a> ☎️</strong> - <strong>⭐ <a href="#changelog">Changelog</a> ⭐</strong>
  </p>
  <p align="center"><img src="https://cdn-images-1.medium.com/max/800/1*CKyKxRXLovcrUOB-s8_jCw.png" width="100%" /></p>
</div>

<!-- Introduction -->
<div id="introduction">
  <h4>📝 Introduction</h4>
</div>

---

[`ExceptionHandler`][rubygems] replaces Rails' [default error pages](https://github.com/rails/rails/tree/ef0b05e78fb0b928c7ef48d3c365dc849af50305/railties/lib/rails/generators/rails/app/templates/public) with dynamic views...

<p align="center">
  <br />
  <img src="./readme/dev.png" />
  <br/>
  <cite>Works by injecting our own <a href="app/controllers/exception_handler/exceptions_controller.rb">controller</a> into the <a href="https://guides.rubyonrails.org/configuring.html#rails-general-configuration"><code>exceptions_app</code></a> middlware hook.</cite>
  <br />--<br />
</p>

Rails' default error pages are **static HTML files**.

Whilst most don't mind this, it bugged the hell out of me - culminating in the development of this gem.

Over the past [**4 years**](https://stackoverflow.com/questions/19103759/rails-4-custom-error-pages-for-404-500-and-where-is-the-default-500-error-mess/19279062#19279062), we've ensured the system is able to operate with the latest version of Rails.

You're now welcome to enjoy the fruits of our labour - with one of the most popular, robust and versatile exception management gems for the Rails framework.

To understand how it works, you need to appreciate how **HTTP errors** are handled...

---

##### 📑 HTTP Error Management

---

The most important thing to note is that *it doesn't matter* which errors Ruby/Rails raises - they *all* need to be wrapped in a [valid HTTP response](https://www.w3.org/Protocols/rfc2616/rfc2616-sec6.html). All transactions online are handled through HTTP, and as such, it pays to understand how it works.

[HTTP](https://en.wikipedia.org/wiki/Hypertext_Transfer_Protocol) is a protocol built on top of [TCP/IP](https://en.wikipedia.org/wiki/Internet_protocol_suite). It was introduced as a means to manage access to "public" Internet-connected computers - the implication being that certain connected systems did not want to be publicly accessible.

Due to the [stateless](https://en.wikipedia.org/wiki/Stateless_protocol) nature of HTTP, each transaction is treated independently to the others. This means that each time you send a request over the protocol, the recipient system will compile a fresh response each time.

Rails already has an HTTP wrapper to turn exceptions into HTTP responses.
only two are used to denote errors → [`4xx`](https://en.wikipedia.org/wiki/List_of_HTTP_status_codes#4xx_Client_errors) + [`5xx`](https://en.wikipedia.org/wiki/List_of_HTTP_status_codes#5xx_Server_errors):

<p align="center">
  <img src="./readme/HTTP.png" width="55%" />
</p>

All Rails is *really* doing is taking "Ruby" errors and giving them an appropriate [HTTP status code](https://en.wikipedia.org/wiki/List_of_HTTP_status_codes) & [message body](https://en.wikipedia.org/wiki/HTTP_message_body) (HTML).

What confuses most is the way in which Rails does this.

The process is handled by [`ActionDispatch::ShowExceptions`](https://github.com/rails/rails/blob/master/actionpack/lib/action_dispatch/middleware/show_exceptions.rb#L44) - middleware which builds a new response out of the erroneous one passed to it by Rails. Through this process, it calls whichever class is present in [`exceptions_app`](http://guides.rubyonrails.org/configuring.html#rails-general-configuration)...

<p align="center">
  <img src="./readme/show_exceptions.png" />
</p>

In other words, what a user *sees* (in the browser) has very little to do with the error Ruby/Rails experienced.

`ExceptionHandler` doesn't change this behaviour - it simply *adds* our own [controller](app/controllers/exception_handler/exceptions_controller.rb)/[view](app/views/exception_handler/exceptions/show.html.erb) to provide the necessary HTML...

---

##### ⛔️ Middleware-Powered Exceptions

---

The key with `ExceptionHandler` is its integration with the [Rack middleware stack](https://guides.rubyonrails.org/rails_on_rack.html#internal-middleware-stack).

Most other "exception" gems hack the core Rails system; ours works *with* Rails to provide a valid set of HTML (using `ActionView` and the asset pipeline) without having to compromise the efficiency of the system...

<p align="center">
  <img src="./readme/middleware.jpg" width="80%" />
</p>

This is important, because the biggest issue for most "exception management" gems is they are simply unable to interface with Rails' view system (and hence cannot show truly custom error pages).

By tapping into the middleware level, the `ExceptionHandler` gem negates the need for manual controller/view management.

The following shows how...

<!-- Sep -->
<p align="center">
  <img src="https://cdn-images-1.medium.com/max/800/1*CKyKxRXLovcrUOB-s8_jCw.png" width="100%" />
</p>

<!-- Installation -->
<div id="installation">
  <h4>⚠️ Installation</h4>
</div>

---

    # Gem
    gem install exception_handler


    # Gemfile
    gem `exception_handler`, '~> 0.8.0.0'

The gem is available on [RubyGems][rubygems] and is fully compatible with Rails 4 + 5.

Installation works by overriding the `exceptions_app` hook - which means that it is *always* present in production.

**You have to do NOTHING to get it working in production.** Just install the gem and it will provide custom 400/500 exception pages. The `4xx` pages will use your app's standard layout, `5xx` has its own [custom layout][layouts]. Both can be [customized][configuration].

To get it working in development, we've included a [`dev`][dev] mode, which overrides the `consider_all_requests_local` option inside Rails. This is consequential; the core of the gem is robust and works on 1,000's of apps which have graciously chosen to run it.

<!-- Sep -->
<p align="center">
  <img src="https://cdn-images-1.medium.com/max/800/1*CKyKxRXLovcrUOB-s8_jCw.png" width="100%" />
</p>

<!-- configuration -->
<div id="configuration">
  <h4>⚙️ Configuration</h4>
</div>

----

<p align="center">
   📁 <a href="#config">Config</a>&nbsp;&nbsp;&nbsp;&nbsp;💻 <a href="#dev" title="Dev Mode">Dev</a>&nbsp;&nbsp;&nbsp;&nbsp;💾 <a href="#db">Database</a>&nbsp;&nbsp;&nbsp;&nbsp;✉️   <a href="#email">Email</a>&nbsp;&nbsp;&nbsp;&nbsp;👓 <a href="#views">Views</a>&nbsp;&nbsp;&nbsp;&nbsp;💬 <a href="#locales">Locales</a>&nbsp;&nbsp;&nbsp;&nbsp;⛔️ <a href="#custom-exceptions">Custom Exceptions</a>
</p>

----

<!-- Config -->
<div id="config">
  <h5>📁 Config</h5>
</div>

The **ONLY** thing you need to configure `ExceptionHandler` is its [`config`](https://github.com/richpeck/exception_handler/blob/master/lib/exception_handler/config.rb) settings.

Whilst the gem **works out of the box** (without any configuration), if you want to manage the [`layouts`](#layouts), [`email`](#email), [`dev`](#dev) or the [`database`](#db), you'll need to set the appropriate values in the config hash.

This is done in `config/application.rb` or `config/environments/[env].rb` ↴

```
# config/application.rb

module YourApp
  class Application < Rails::Application

    # => This is an example of ALL available config options
    # => You're able to see exactly how it works here:
    # => https://github.com/richpeck/exception_handler/blob/master/lib/exception_handler/config.rb

    # => Config hash (no initializer required)
    config.exception_handler = {
      dev:        nil, # allows you to turn ExceptionHandler "on" in development
      db:         nil, # allocates a "table name" into which exceptions are saved (defaults to nil)
      email:      nil, # sends exception emails to a listed email (string // "you@email.com")

      # Custom Exceptions
      custom_exceptions: {
        #'ActionController::RoutingError' => :not_found # => example
      },

      # On default 5xx error page, social media links included
      social: {        
        facebook: nil, # Facebook page name   
        twitter:  nil, # Twitter handle  
        youtube:  nil, # Youtube channel name / ID
        linkedin: nil, # LinkedIn name
        fusion:   nil  # FL Fusion handle
      },  

      # This is an entirely NEW structure for the "layouts" area
      # You're able to define layouts, notifications etc ↴

      # All keys interpolated as strings, so you can use symbols, strings or integers where necessary
      exceptions: {

        :all => {
          layout: "exception", # define layout
          notification: true, # (false by default)
          deliver: #something here to control the type of response
        },
        :4xx => {
          layout: nil, # define layout
          notification: true, # (false by default)
          deliver: #something here to control the type of response    
        },    
        :5xx => {
          layout: "exception", # define layout
          notification: true, # (false by default)
          deliver: #something here to control the type of response    
        },
        500 => {
          layout: "exception", # define layout
          notification: true, # (false by default)
          deliver: #something here to control the type of response    
        },

        # This is the old structure
        # Still works but will be deprecated in future versions

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
```  

For a full retinue of the available options, you'll be best looking at the [`config`](https://github.com/richpeck/exception_handler/blob/master/lib/exception_handler/config.rb) file itself.

--

If using an [`engine`](http://guides.rubyonrails.org/engines.html), you **DON'T need an `initializer`**:

    # lib/engine.rb
    module YourModule
      class Engine < Rails::Engine

        # => ExceptionHandler
        # => Works in and out of an initializer
        config.exception_handler = {
          dev: nil, # => this will not load the gem in development
          db:  true # => this will use the :errors table to store exceptions
        }
      end

    end

The best thing about using a `config` options block is that you are able to only define the options that you require.

If you have particular options you *only* wish to run in `staging`, or have single options for `production` etc, this setup gives you the ability to manage it properly...

---

<!-- Dev -->
<div id="dev">
  <h5>💻 Dev</h5>
</div>

As explained, `ExceptionHandler` does *not* work in `development` by default.

This is because it overrides the `exceptions_app` middleware hook - which is *only* invoked in `production` or `staging`...

<p align="center">
  <img src="./readme/dev.png" />
</p>

To get it working in `development`, you need to override the [`config.consider_all_requests_local`](http://guides.rubyonrails.org/configuring.html#rails-general-configuration) setting (a standard component of Rails) - setting it to "false" ↴

<p align="center">
  <img src="./readme/local_requests.jpg" />
</p>

This is normally done by changing the setting in your Rails config files. However, to make the process simpler for `ExceptionHandler`- we've added a `dev` option which allows you to override the hook through the context of the gem...

```
# config/application.rb
config.exception_handler = { dev: true }
```

This disables [`config.consider_all_requests_local`](http://guides.rubyonrails.org/configuring.html#rails-general-configuration), making Rails behave as it would in production.

Whilst simple, it's not recommended for extended use. Very good for testing new ideas etc.

---

<!-- DB -->
<div id="db">
  <h5>💾 DB</h5>
</div>

If you want to save exceptions to your database, you will need to migrate a new table.

Ths is done automatically with the latest version of `ExceptionHandler`.

To do this, once you've enabled the option, run `rails db:migrate` from your console. Our new [`migration system`](https://github.com/richpeck/exception_handler/tree/readme#migrations) will automatically run the migration.

```
# config/application.rb
config.exception_handler = { db: true }
```

This enables `ActiveRecord::Base` on the [`Exception`](app/models/exception_handler/exception.rb) class, allowing us to save to the database.

In order for this to work, your db needs the correct table.

---

<!-- Email -->
<div id="email">
  <h5>✉️ Email</h5>
</div>

`ExceptionHandler` also sends email notifications.

If you want to receive emails whenever your application raises an error, you can do so by adding your email to the config:

    # config/application.rb
    config.exception_handler = {
      email: "your@email.com"
    }

> **Please Note** this requires [`ActionMailer`](http://guides.rubyonrails.org/action_mailer_basics.html). If you don't have any outbound SMTP server, [`SendGrid`](http://sendgrid.com) is free.

From version `0.8.0.0`, you're able to define whether email notifications are sent on a per-error basis:

    # config/application.rb
    config.exception_handlder = {
      exceptions: {
        :all => { notification: true },
        :50x => { notification: false },
        500 =>  { notification: false }
      }
    }

---

<!-- Views -->
<div id="views">
  <h5>👓 Views</h5>
</div>

The **views** system in `ExceptionHandler` is modular.

What *most* people want out of the view is to change the way it ***looks***. This can be done without changing the exception "view" itself...

[[ image ]]

To better explain, if [`ExceptionsController`](https://github.com/richpeck/exception_handler/blob/0.8/app/controllers/exception_handler/exceptions_controller.rb) is invoked (by `exceptions_app`), it has **ONE** method ([`show`](https://github.com/richpeck/exception_handler/blob/0.8/app/controllers/exception_handler/exceptions_controller.rb#L42)). This method calls the [`show` view](https://github.com/richpeck/exception_handler/blob/0.8/app/views/exception_handler/exceptions/show.html.erb), which is *entirely* dependent on the locales for content & the layout for the look.

This means that if you wish to change how the view "looks" - you're *either* going to want to change your *layouts* or the [*locales*](#locales). There is NO reason to change the `show` view itself - it's succinct and entirely modular. Whilst you're definitely at liberty to change it, you'll just be making the issue more complicated than it needs to be.

-

If you wish to change the "layout" / "look", there are **two** options...

 * Firstly, you can create your own layout. This is done by changing the

 * Secondly,

---

<!-- Locales -->
<div id="locales">
  <h5>💬 Locales</h5>
</div>

[Locales](https://github.com/richpeck/exception_handler/blob/Readme/config/locales/exception_handler.en.yml) are used to create interchangeable text (translations/internationalization)...

[[ image ]]

In `ExceptionHandler`, we use it to provide the wording for each error which may be shown to users.

By default, the English name of the error is used (`"404"` will appear as `"Not Found"`) - if you want to create custom messages, you're able to do so by referencing the error's ["status_code"](https://github.com/rack/rack/blob/master/lib/rack/utils.rb#L492) within your locales file:

    # config/locales/en.yml
    en:
      exception_handler:
        not_found:              "Your message here" # -> 404 page
        unauthorized:           "You need to login to continue"
        internal_server_error:  "This is a test to show the %{status} of the error"

You get access to [`%{message}` and `%{status}`](https://github.com/richpeck/exception_handler/blob/Readme/app/views/exception_handler/exceptions/show.html.erb#L1), both inferring from an [`@exception`](https://github.com/richpeck/exception_handler/blob/master/app/controllers/exception_handler/exceptions_controller.rb#L20) object we invoke in the controller...

 - `%{message}` is the error's actual message ("XYZ file could not be shown")
 - `%{status}` is the error's status code ("Internal Server Error")

--

By default, the provided translation file is as follows:

    # config/locales/en.yml
    en:
      exception_handler:
        internal_server_error: "<strong>%{status} Error</strong> %{message}"

---

<!-- Layouts -->
<div id="layouts">
  <h5>📋 Layouts</h5>
</div>

The most attractive feature of `ExceptionHandler` (for most) is its ability to manage [`layouts`](https://guides.rubyonrails.org/layouts_and_rendering.html#structuring-layouts) dependent on HTTP status...

[[ image ]]

The reason this is important is due to the way in which Rails works → the "layout" is a "wrapper" for the returned HTML (the "styling" of a page). If you have no layout, you'll end up with the "view" HTML and nothing else.

This means that if you want to change the "look" of a Rails action, you simply have to be able to change the `layout`. You should not change the view at all.

To this end, `ExceptionHandler` has been designed around providing a [SINGLE VIEW](app/controllers/exception_handler/exceptions_controller.rb#L44) for exceptions. This view does not need to change (although you're welcome to use a [`generator`][generators] to do so) - the key is the `layout` that's assigned...

- [`4xx`](https://en.wikipedia.org/wiki/List_of_HTTP_status_codes#4xx_Client_errors) errors are given a `nil` layout (by default) (inherits from `ApplicationController` in your main app)
- [`5xx`](https://en.wikipedia.org/wiki/List_of_HTTP_status_codes#5xx_Server_errors) errors are assigned our own [`exception`](app/views/layouts/exception.html.erb) layout:

````
# config/application.rb
config.exception_handler = {

  # The new syntax allows us to assign different values to each HTTP status code
  # At the moment, only 'layout' & 'notification' are supported
  # We plan to include several more in the future...

  exceptions: {
    :all => { layout: nil } #-> this will inherit from ApplicationController's layout
  }

}
````

The `layout` system has changed between [`0.7.7.0`](releases/tag/v0.7.7.0) and [`0.8.0.0`](releases/tag/v0.8.0.0).

Building on the former's adoption of HTTP status-centric layouts, it is now the case that we have the `all`, `5xx` and `4xx` options - allowing us to manage the layouts for blocks of HTTP errors respectively:

    # config/application.rb
    config.exception_handler = {

      # Old (still works)
      # No "all" / "4xx"/"5xx" options
      layouts: {
        500 => 'exception',
        501 => 'exception'
      },

      # New
      exceptions: {
        :all  => { layout: 'exception' },
        '4xx' => { layout: 'exception' },
        '5xx' => { layout: 'exception' }, # -> this overrides the :all declaration
        500   => { layout: nil } # -> this overrides the 5xx declaration
      }

    }

We've bundled the [`exception`](app/views/layouts/exception.html.erb) layout for `5xx` errors because since these denote internal server errors, it's best to isolate the view system as much as possible. Whilst you're at liberty to change it, we've found it sufficient for most use-cases.

---

<!-- Custom Exceptions -->
<div id="custom-exceptions">
  <h5>⛔️ Custom Exceptions</h5>
</div>

As mentioned, Rails' primary role is to convert Ruby exceptions into HTTP errors.

Part of this process involves mapping Ruby/Rails exceptions to the equivalent HTTP status code.

This is done with [`config.action_dispatch.rescue_responses`](https://github.com/rack/rack/blob/master/lib/rack/utils.rb#L492)...

<p align="center">
  <img src="./readme/custom_exceptions.png" />
</p>

Whilst this works well, it may be the case that you want to map your own classes to an HTTP status code (default is `Internal Server Error`).

If you wanted to keep this functionality inside `ExceptionHandler`, you're able to do it as follows:

    # config/application.rb
    config.exception_handler = {
      custom_exceptions: {
        'CustomClass::Exception' => :not_found
      }
    }

Alternatively, you're able to still do it with the default Rails behaviour:

    # config/application.rb
    config.action_dispatch.rescue_responses = { 'CustomClass::Exception' => :not_found }

---

<!-- Generators -->
<div id="generators">
  <h5>💼 Generators</h5>
</div>

If you want to edit the `controller`, `views`, `model` or `assets`, you're able to invoke them in your own application.

This is done - as with other gems - with a single [`generator`](https://github.com/richpeck/exception_handler/blob/master/lib/generators/exception_handler/views_generator.rb) which takes a series of arguments:

    rails g exception_handler:views
    rails g exception_handler:views -v views
    rails g exception_handler:views -v controllers
    rails g exception_handler:views -v models
    rails g exception_handler:views -v assets
    rails g exception_handler:views -v views controllers models assets

If you don't include any switches, this will copy **all** `ExceptionHandler`'s folders put into your app.

Each switch defines which folders you want (EG `-v views` will only copy `views` dir).

---

<!-- Migrations -->
<div id="migrations">
  <h5>✔️ Migrations</h5>
</div>

You **DON'T** need to generate a migration anymore.

From [`0.7.5`](https://github.com/richpeck/exception_handler/releases/tag/0.7.5), the `migration` generator has been removed in favour of our own [migration system](lib/exception_handler/engine.rb#L58).

The reason we did this was so not to pollute your migrations folder with a worthless file. Our migration doesn't need to be changed - we only have to get it into the database and the gem takes care of the rest...

> If you set the [`db`][db] option in config, run `rails db:migrate` and the migration will be run.

To rollback, use the following:

    rails db:migrate:down VERSION=000000

The drawback to this is that if you remove `ExceptionHandler` before you rollback the migration, it won't exist anymore.

You can **only** fire the `rollback` when you have `ExceptionHandler` installed.

<!-- Sep -->
<p align="center">
  <img src="https://cdn-images-1.medium.com/max/800/1*CKyKxRXLovcrUOB-s8_jCw.png" width="100%" />
</p>

<!-- Support -->
<div id="support">
  <h4>☎️ Support</h4>
</div>

---

You're welcome to contact me directly at <a href="mailto:rpeck@frontlineutilities.co.uk">rpeck@frontlineutilities.co.uk</a>.

Alternatively, you may wish to post on our [GitHub Issues](https://github.com/richpeck/exception_handler/issues), or [StackOverflow](https://stackoverflow.com/questions/tagged/ruby-on-rails+exceptionhandler).

--


[![Medium](./readme/medium.png)](https://medium.com/ruby-on-rails-web-application-development/custom-400-500-error-pages-in-ruby-on-rails-exception-handler-3a04975e4677)

<!-- Sep -->
<p align="center">
  <img src="https://cdn-images-1.medium.com/max/800/1*CKyKxRXLovcrUOB-s8_jCw.png" width="100%" />
</p>

<!-- Changelog -->
<div id="changelog">
  <h4>⭐ Changelog</h4>
</div>

---

[**1.0.0.0**](https://github.com/richpeck/exception_handler/releases/tag/v1.0.0.0)
  - [ ] TBA

[**0.8.0.0**](https://github.com/richpeck/exception_handler/releases/tag/v0.8.0.0)
 - [x] [README](https://github.com/richpeck/exception_handler/issues/52) (focus on utility)
 - [x] Introduction of `4xx`,`5xx`,`:all` for layouts config
 - [x] Changed `layouts` to `exceptions` in config    
 - [x] Email improvement
 - [x] Streamlined migration
 - [x] Updated model

[**0.7.7.0**](https://github.com/richpeck/exception_handler/releases/tag/v0.7.7.0)
 - [x] [HTTP status layouts](#layouts)

**0.7.0.0**
 - [x] Wildcard mime types
 - [x] [Custom exceptions](#custom_exceptions)
 - [x] Test suite integration
 - [x] [Model backend](#database)
 - [x] Sprockets 4+
 - [x] New layout
 - [x] Readme / wiki overhaul

**0.6.5.0**
 - [x] Streamlined interface
 - [x] ActiveRecord / Middleware overhaul
 - [x] Supports Sprockets 4+ ([`manifest.js`](http://eileencodes.com/posts/the-sprockets-4-manifest/))
 - [x] Email integration
 - [x] Asset overhaul & improvement
 - [x] Removed dependencies

**0.5.0.0**
 - [x] Locales
 - [x] Email notifications
 - [x] Full test suite
 - [x] Rails 4.2 & Rails 5.0 native ([`request.env`](https://github.com/rails/rails/commit/05934d24aff62d66fc62621aa38dae6456e276be) fix)
 - [x] Controller fixed
 - [x] `DB` fixed
 - [x] Legacy initializer support ([more](https://github.com/richpeck/exception_handler/wiki/1-Setup))
 - [x] Rails asset management improvement
 - [x] Reduced gem file size

**0.4.7.0**
 - [x] New config system
 - [x] Fixed controller layout issues
 - [x] Streamlined middleware
 - [x] New layout & interface

 <!-- Sep -->
 <p align="center">
   <img src="https://cdn-images-1.medium.com/max/800/1*CKyKxRXLovcrUOB-s8_jCw.png" width="100%" />
 </p>

 [![404 + 500 Errors][banner]][rubygems]

 <p align="center">
   <strong><a href="https://rubygems.org/gems/exception_handler"><code>ExceptionHandler</code></a> provides custom error pages gem for Rails 4 & 5...</strong>
   <br />
   No other gem is as simple or effective at providing branded exception pages in production
 </p>

 <p align="center">
   <a href="http://badge.fury.io/rb/exception_handler"><img src="https://badge.fury.io/rb/exception_handler.svg" align="absmiddle"></a>
   <a href="http://rubygems.org/gems/exception_handler"><img src="http://ruby-gem-downloads-badge.herokuapp.com/exception_handler/0.5.1?type=total&color=brightgreen" align="absmiddle" /></a>
   <a href="https://codeclimate.com/github/richpeck/exception_handler"><img src="https://codeclimate.com/github/richpeck/exception_handler/badges/gpa.svg" align="absmiddle"/></a>
   <a href='https://coveralls.io/github/richpeck/exception_handler?branch=master'><img src='https://coveralls.io/repos/github/richpeck/exception_handler/badge.svg?branch=master' alt='Coverage Status' align="absmiddle" /></a>
   <a href="https://travis-ci.org/richpeck/exception_handler"><img src="https://travis-ci.org/richpeck/exception_handler.svg?branch=master" align="absmiddle"></a>
 </p>

 <p align="center">
   <strong>➡️ <a href="https://rubygems.org/gems/exception_handler">Download & Info</a> ⬅️</strong>
 </p>

 <!-- Sep -->
 <p align="center">
   <img src="https://cdn-images-1.medium.com/max/800/1*CKyKxRXLovcrUOB-s8_jCw.png" width="100%" />
 </p>

:copyright: <a href="http://www.fl.co.uk" align="absmiddle" ><img src="readme/fl.jpg" height="22" align="absmiddle" /></a> <a href="http://stackoverflow.com/users/1143732/richard-peck?tab=profile" align="absmiddle" ><img src="https://avatars0.githubusercontent.com/u/1104431" height="22" align="absmiddle" /></a> <a href="https://github.com/joehilton" align="absmiddle" ><img src="https://avatars2.githubusercontent.com/u/5063592?s=460&v=4" height="22" align="absmiddle" /></a> <a href="https://github.com/toymachiner62" align="absmiddle" ><img src="https://avatars3.githubusercontent.com/u/485782" height="22" align="absmiddle" /></a> <a href="https://github.com/andrewclink" align="absmiddle" ><img src="https://avatars0.githubusercontent.com/u/688916" height="22" align="absmiddle" /></a> <a href="https://github.com/Startouf" align="absmiddle" ><img src="https://avatars2.githubusercontent.com/u/7388889" height="22" align="absmiddle" /></a> <a href="https://github.com/Tonkonozhenko" align="absmiddle" ><img src="https://avatars0.githubusercontent.com/u/1307646" height="22" align="absmiddle" /></a> <a href="https://github.com/mabako" align="absmiddle" ><img src="https://avatars3.githubusercontent.com/u/125113" height="22" align="absmiddle" /></a> <a href="https://github.com/frankzhao" align="absmiddle" ><img src="https://avatars3.githubusercontent.com/u/555499" height="22" align="absmiddle" /></a>


<!-- ################################### -->
<!-- ################################### -->

<!-- Refs -->
<!-- Comments http://stackoverflow.com/a/20885980/1143732 -->
<!-- Images   https://github.com/adam-p/markdown-here/wiki/Markdown-Cheatsheet#images -->

<!-- Images -->
[banner]:readme/banner.jpg

<!-- Links -->
[rubygems]: http://rubygems.org/gems/exception_handler

[10x]: https://en.wikipedia.org/wiki/List_of_HTTP_status_codes#1xx_Informational_responses
[20x]: https://en.wikipedia.org/wiki/List_of_HTTP_status_codes#2xx_Success
[30x]: https://en.wikipedia.org/wiki/List_of_HTTP_status_codes#3xx_Redirection
[40x]: https://en.wikipedia.org/wiki/List_of_HTTP_status_codes#4xx_Client_errors
[50x]: https://en.wikipedia.org/wiki/List_of_HTTP_status_codes#5xx_Server_errors

<!-- Local Links -->
[db]: #db
[email]: #email
[dev]: #dev
[layouts]: #layouts
[locales]: #locales
[configuration]: #configuration
[generators]: #generators
[custom-exceptions]: #custom-exceptions

<!-- ################################### -->
<!-- ################################### -->
