![Exception Handler](readme/title.jpg "Exception Handler Logo")

<p align="center">
  <font size="4"><strong>Custom 404 & 500 production error pages for Rails 4 & 5.</font></strong>
</p>

<p align="center">
  <a href="http://badge.fury.io/rb/exception_handler"><img src="https://badge.fury.io/rb/exception_handler.svg" align="absmiddle"></a>
  <a href="http://rubygems.org/richpeck/exception_handler"><img src="http://ruby-gem-downloads-badge.herokuapp.com/exception_handler/0.5.1?type=total&color=brightgreen" align="absmiddle" /></a>
  <a href="https://codeclimate.com/github/richpeck/exception_handler"><img src="https://codeclimate.com/github/richpeck/exception_handler/badges/gpa.svg" align="absmiddle"/></a>
  <a href="https://gemnasium.com/richpeck/exception_handler"><img src="https://gemnasium.com/richpeck/exception_handler.svg" align="absmiddle"></a>
  <a href='https://coveralls.io/github/richpeck/exception_handler?branch=master'><img src='https://coveralls.io/repos/github/richpeck/exception_handler/badge.svg?branch=master' alt='Coverage Status' align="absmiddle" /></a>
  <a href="https://travis-ci.org/richpeck/exception_handler"><img src="https://travis-ci.org/richpeck/exception_handler.svg?branch=master" align="absmiddle"></a>
</p>

<p align="center">
  <strong><a href="#user-content-install">Install</a></strong> → <strong><a href="#user-content-config">Setup</a></strong> → <strong><a href="#user-content-support">Support</a></strong>
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
  <img src="readme/titles/rails5.png" title="Fully Rails 5 Compatible" width="550" />
</p>

<p align="center">
  <img src="readme/check_02.png" height="22" title="New Controller"           align="absmiddle" />&nbsp; <strong align="absmiddle">New Controller</strong> &nbsp;
  <img src="readme/check_02.png" height="22" title="New Middleware"           align="absmiddle" />&nbsp; <strong align="absmiddle">New Middleware</strong> &nbsp;
  <img src="readme/check_02.png" height="22" title="Full Test Suite"          align="absmiddle" />&nbsp; <strong align="absmiddle">Full Test Suite</strong> &nbsp;
  <img src="readme/check_02.png" height="22" title="Rails 4 & 5 Compatible"   align="absmiddle" />&nbsp; <strong align="absmiddle">Fully Rails 4 & 5 Compatible</strong> &nbsp;
</p>

Brand new `controller` & `middleware` have made **`ExceptionHandler`** even more powerful & efficient. Now you can use `ExceptionHandler` with a single click → **plug and play** custom exception pages:

<p align="center">
  <br />
  <img src="readme/404.png" title="400 Errors" width="430" />
  <img src="readme/500.png" title="500 Errors" width="430" />
</p>

With major upgrades to the backend, **ExceptionHandler [0.7.0][latest]** is the leading exception management solution for Rails 5:

<p align="center">
  <h3>Features</h3>
  Custom 500 Errors Layout || DB || Model || Config || Email || 400 Default Layout || Sprockets 4 || Custom Exceptions
</p>

**ExceptionHandler works 100% with Rails 5 and Sprockets 4**. It hooks DIRECTLY into your existing CSS to create a professional exception interface with NO work on your part…

----

<p align="center">
  <br />
  <img src="readme/titles/middleware.png" title="Middleware-Powered Exceptions" width="400" />
</p>

The secret lies in [**`config.exceptions_app`**][exception_app] ↴


![config.exceptions_app - The key to all Rails exceptions][exceptions_app]

Because we handle **`requests`** directly (`message`, `details`, `user agent`), `ExceptionHandler` populates our custom `view` with any details required. This gives us the ability to **maintain your branding** (layout / css) even when exceptions are raised:

![Exceptions handled by the ActiveDispatch::ShowExceptions Middleware][middleware]

This is important at is means `ExceptionHandler` has absolutely ZERO bloat on an app. Rails is invoked ONCE (not twice like it is when using routes), delivering a response JUST LIKE if an exception wasn't raised.

<p align="center">
  <strong>The <i>ONLY</i> professional solution to catch, process & handle Rails exceptions <i>WITHOUT</i> BLOAT:</strong>
</p>

<p align="center">
  <img src="readme/controller_middleware.jpg" title="ExceptionsController compiles the exception & delivers to the front-end" />
</p>

The REAL beauty of ExceptionHandler is that you only have to serve **two** error responses → `400` & `500`. This is per the [HTTP spec](https://www.w3.org/Protocols/rfc2616/rfc2616-sec10.html#sec10.4) - a browser CANNOT read any other form of error.

This means that we can use a single controller action to build our `@exception` object, responding to the HTTP request with the status code raised by the exception. We have built this into a simple & effective solution:

----------

<p align="center" id="install">
  <br />
  <img src="readme/titles/install.png" title="1 Click Install for ExceptionHandler 0.7.0 on Rails 5" width="400" />
</p>

[![Gemfile][gemfile]][rubygems] [![Gem][gem]][rubygems]

`ExceptionHandler`'s **config** system stores the - you just need to install the gem & let it run.

If you want to change *any* settings (detailed [below](#user-content-config)), you **simply** need to change `config/application.rb` or `config/environments/your_env.rb`. The ***POWER*** of this *new config system* means you're able to deploy `ExceptionHandler` in the most unobtrusive, versatile way possible:

----

**`ExceptionHandler 0.7.0`** has *drastically* improved our famous 1-click install.

Not only have we removed all the bloat, but our initialization process now relies on a *single* hook which will set all the config variables as required. This is stark difference to the myriad of poorly-designed gems which cause massive lag in your Rails initialization process. `ExceptionHandler` is now more streamlined than ever:

<p align="center">
  <img src="readme/defaults.jpg" title="ExceptionHandler Default Config Options">
</p>

The **MAGIC** lies in the [`environment files`](http://guides.rubyonrails.org/configuring.html#creating-rails-environments).

Instead of dopey initializers (which slow the system down), you can just use the Rails config files to set environment-dependent options. This allows us to maximize performance without any of the overhead associated with old-fashioned gems.

> **IMPORTANT**
>
> If you're upgrading from >= `0.4.7`, you need to **remove your `exception_handler` initializer**.
>
> We've changed the load process to use Rails app config - **you don't need the `exception_handler` initializer any more**

----

<p id="defaults">
  <img src="readme/titles/setup/defaults.jpg" title="Defaults" height="75" border="2" />
</p>

As can be seen in[`config`](/lib/exception_handler/config.rb), the following are all the options `ExceptionHandler` accepts:

<p align="center">
  <img src="readme/defaults.jpg" title="ExceptionHandler Default Configuration Options">
</p>

    # Defaults
    DEFAULTS = {
      dev: 	  false, #-> defaults to "false" for dev mode
      db:     false, #-> defaults to :errors if true, else use "table_name" / :table_name
      email: 	false, #-> requires string email and ActionMailer
      social: {
        facebook: { name: "frontline.utilities", url: "https://facebook.com" },
        twitter:  { name: "frontlineutils",      url: "http://twitter.com" },
        youtube:  { name: "frontlineutils",      url: "https://youtube.com/user" },
        linkedin: { name: "frontline-utilities", url: "https://linkedin.com/company" },
        fusion:   { name: "flutils",             url: "https://frontlinefusion.com" }
      },
      layouts: {
        "400" => nil,         # => inherits from "ApplicationController" layout
        "500" => "exception"
      },
    }

You can apply any of the above defaults into one of the Rails [`environment files`](http://guides.rubyonrails.org/configuring.html#creating-rails-environments):

- `config/application.rb`
- `config/environments/development.rb`
- `config/environments/production.rb`
- `config/environments/staging.rb`

The benefit of this is that it gives you the ability to customize `ExceptionHandler` for *any* of your environments. Contrary to a shitty `initializer`, you're able to sculpt the gem to work for YOU.

----

![Development Mode][dev]

Want to test in the `dev` environment?

    # config/application.rb
    config.exception_handler = {
      dev: true # -> Runs in development mode WITHOUT changing the app environment files
    }

<img src="readme/dev.jpg" title="ExceptionHandler Dev Mode - NEW!!!!!">

[`config.exceptions_app`](http://guides.rubyonrails.org/configuring.html#rails-general-configuration) *only* works when you have [`config.consider_all_requests_local = true`](http://blog.bigbinary.com/2009/02/05/rescue_action_in_public-local_request-and-how-to-configure-local_request.html), which is `true` in `development`:

> **`config.consider_all_requests_local`** is a flag. If true then any error will cause detailed debugging information to be dumped in the `HTTP` response, and the `Rails::Info controller` will show the application runtime context in `/rails/info/properties`. `True` by default in development and test environments, and false in production mode. For finer-grained control, set this to false and implement `local_request?` in controllers to specify which requests should provide debugging information on errors.


If you wish to test **`ExceptionHandler`** in `development`, you'll have to use the `dev: true` option in your `exception_handler` config, *or* change `config.consider_all_requests_local = true` in `config/development.rb`.

----

<br />
<img src="readme/titles/layout.jpg" title="Layout" id="layout" />

One of the most critial aspects of **`ExceptionHandler`** is the custom `Exception` layout.

If you want to change the layout (for `500` error pages), you need to use the following:

<img src="readme/layout.jpg" title="Custom Exceptions Layout For ExceptionHandler" />

You'll need to [generate](#user-content-view) it into your application before being able to edit:

----

![View][view]

**`ExceptionHandler`** comes with its own inbuilt views & controller.

If you want to change it, you need to add the views into your app with the [`generator`](/lib/generators/exception_handler/views_generator.rb)

    $ rails generate exception_handler:views                                            #-> controller, models, helpers, views & assets
    $ rails generate exception_handler:views -v views controllers models helpers assets #-> remove as appropriate to install individual assets

--

<img src="readme/show.jpg" title="ExceptionHandler Show view" />

`ExceptionHandler` uses `exceptions#show` -- located in **`app/views/exception_handler/show.html.erb`** designed to work for all exceptions.

By default, it is split for use with different layouts, data being available to both.

This works exactly the same as the other views in your app (IE the `exceptions controller` invokes the `show` action)

----

![Database][db]

If you want to store exceptions in your `db`, you will need to set up a **migration**:

    $ rails generate exception_handler:migration
    $ rake db:migrate

You will also need to ensure your config db option is either `true` or `"table_name"`:

<img src="readme/db.jpg" title="ExceptionHandler DB Config">

<img src="readme/db_screenshot.jpg" title="ExceptionHandler Database">

> **IMPORTANT**
>
> `ExceptionHandler`'s [new config system](https://github.com/richpeck/exception_handler/wiki/Setup) is `environment` agnostic.
>
> **Where you declare your `db` setting will change depending on your environment**
>
> If you declare `db` in `application.rb`, it will be applicable for all `environments`; only declaring in `production.rb` will set it for production *only*.

----

### ![Support][support]

We offer support through [GitHub](http://github.com/richpeck/exception_handler/issues) and [StackOverflow](http://stackoverflow.com/questions/ask?tags=ruby-on-rails+exception-handler).

Whilst we can't guarantee response times, we are always eager to make sure `ExceptionHandler` is the most secure, robust and effective solution for Rails exception pages. You can use the links below to access support directly:

Github (~1hr) | Stackoverflow (~24hrs)
:----: | :----:
[![StackOverflow](readme/github.jpg)](https://github.com/richpeck/exception_handler/issues) | [![StackOverflow](readme/stackoverflow.jpg)](http://stackoverflow.com/questions/ask?tags=ruby-on-rails+exception-handler)

We use **`ExceptionHandler`** in production, so have a vested interest in keeping it running smoothly.

---

# ![Changelog - Current Version 0.7.0][changelog]

Current version is [**`0.7.0`**](https://github.com/richpeck/exception_handler/releases/latest)

Functionality remains consistent with previous releases, main difference will be the way in which they handle backend processes. **`0.7.0`** completely overhauled the backend, making the `controller`, `model` and `middleware` much more streamlined.

The biggest update for **`0.7.0.`** has been the removal of most middleware, putting the entire system into a central class. This not only allows us to centralize the data structure, but also remove many files which didn't matter.

Here is a rundown of what's been implemented ↴

### [→ 0.7.0](https://github.com/richpeck/exception_handler/releases/tag/0.7.0)
 - [ ] Wildcard mime types
 - [ ] Custom exceptions
 - [x] Test suite integration
 - [ ] Exception "mapping" (choose which exceptions to handle)
 - [x] [Email](https://github.com/richpeck/exception_handler/wiki/2-Email)
 - [x] Model backend
 - [x] Sprockets 4+
 - [x] Readme / wiki overhaul

### [→ 0.6.5](https://github.com/richpeck/exception_handler/releases/tag/0.6.5)
 - [x] Streamlined interface
 - [x] ActiveRecord / Middleware overhaul
 - [x] Supports Sprockets 4+ ([`manifest.js`](http://eileencodes.com/posts/the-sprockets-4-manifest/))
 - [x] Email integration
 - [x] Asset overhaul & improvement
 - [x] Removed dependencies

### [→ 0.5.0](https://github.com/richpeck/exception_handler/releases/tag/0.5.0)
 - [x] Added locales
 - [x] Email notifications
 - [x] Full test suite
 - [x] Rails 4.2 & Rails 5.0 native ([`request.env`](https://github.com/rails/rails/commit/05934d24aff62d66fc62621aa38dae6456e276be) fix)
 - [x] Controller fixed
 - [x] `DB` fixed
 - [x] Legacy initializer support ([more](https://github.com/richpeck/exception_handler/wiki/1-Setup))
 - [x] Rails asset management improvement
 - [x] Reduced gem file

### [→ 0.4.6](https://github.com/richpeck/exception_handler/releases/tag/0.4.6)
 - [x] New config system ([more](https://github.com/richpeck/exception_handler/wiki/1-Setup))
 - [x] Fixed controller layout issues
 - [x] Streamlined middleware
 - [x] New layout & interface implementation

----------

:copyright: <a href="http://www.frontlineutilities.co.uk" align="absmiddle" ><img src="readme/fl.jpg" height="22" align="absmiddle" /></a> <a href="http://stackoverflow.com/users/1143732/richard-peck?tab=profile" align="absmiddle" ><img src="https://avatars0.githubusercontent.com/u/1104431" height="22" align="absmiddle" /></a>

<!-- ################################### -->
<!-- ################################### -->

<!-- Refs -->
<!-- Comments http://stackoverflow.com/a/20885980/1143732 -->
<!-- Images   https://github.com/adam-p/markdown-here/wiki/Markdown-Cheatsheet#images -->

<!-- Images -->
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
[latest]:                   https://github.com/richpeck/exception_handler/releases/latest
[show_exception]: https://github.com/rails/rails/blob/4-0-stable/actionpack/lib/action_dispatch/middleware/show_exceptions.rb
[exception_app]:          http://guides.rubyonrails.org/configuring.html#rails-general-configuration
[rubygems]:                 http://rubygems.org/gems/exception_handler
[frontlineutilities.co.uk]: http://www.frontlineutilities.co.uk
[stackoverflow.com]:        http://stackoverflow.com/users/1143732/richard-peck?tab=profile
[fork]:                     #fork-destination-box
[pull]:                     http://github.com/richpeck/exception_handler/pulls

<!-- ################################### -->
<!-- ################################### -->
