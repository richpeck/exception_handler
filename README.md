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
  <img src="readme/400.png" title="400 Errors" width="430" />
  <img src="readme/500.png" title="500 Errors" width="430" />
</p>

For over 3 years, `ExceptionHandler` has provided production-level Rails exception handling for `400` and `500` errors. Now - with version `0.7.0` - it's even more powerful:

----

<p align="center">
  <img src="readme/titles/middleware.png" title="Middleware-Powered Exceptions" width="400" />
</p>

The secret lies in [**`config.exceptions_app`**][exception_app] ↴

![Exceptions handled by the ActiveDispatch::ShowExceptions Middleware][middleware]

All Rails exceptions are handled with the `config.exceptions_app` callback. This is assigned in the `config/application.rb` or `config/environments/*.rb files` - it needs to be a callback:

![config.exceptions_app][config.exceptions_app]

Every time Rails raises an exception, the [`ShowExceptions`][show_exception] middleware takes the request and forwards it to the `exceptions_app` hook. This hook is expected to return a response; which response is up to you:

![config.exceptions_app - The key to all Rails exceptions][exceptions_app]

`ExceptionHandler` injects our [controller](app/controllers/exception_handler/exceptions_controller.rb) into `exceptions_app`, meaning **`requests`** are handled directly (`message`, `details`, `user agent`). `ExceptionHandler` populates our custom `view` with any details required, giving us the ability to **maintain branding** (layout / css) even when exceptions are raised:

![Exceptions handled by the ActiveDispatch::ShowExceptions Middleware][middleware]

This means `ExceptionHandler` has absolutely ZERO bloat. Rails is invoked ONCE (not twice like it is when using routes), delivering a response JUST LIKE if an exception wasn't raised.

<p align="center">
  <strong>The <i>ONLY</i> professional solution to catch, process & handle Rails exceptions <i>WITHOUT</i> BLOAT:</strong>
</p>

<p align="center">
  <img src="readme/controller_middleware.jpg" title="ExceptionsController compiles the exception & delivers to the front-end" />
</p>

The REAL beauty of ExceptionHandler is that **you only have to serve two error responses** → `400` & `500`. This is per the [HTTP spec](https://www.w3.org/Protocols/rfc2616/rfc2616-sec10.html#sec10.4) - a browser CANNOT read any other form of error.

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

## Config

From [`0.4.7`](https://github.com/richpeck/exception_handler/releases/tag/0.4.6), **`ExceptionHandler`** manages its config from the central Rails config.


## Database

## Email

## Layout

---


## Custom Exceptions

Due to popular demand, we investigated how to add **custom exceptions**.

Turns out the functionality is *already* built into Rails [`config.action_dispatch.rescue_responses`][rescue_responses] ↴

![ActionDispatch][config.action_dispatch.rescue_responses]

Because the browser can only read `4xx` or `5xx` HTTP errors, any exception raised inside Rails has to be interpolated. This is handled by the `action_dispatch.rescue_responses` middleware.

Specifically, you have to register your custom exception against an [HTTP response code][status_codes]. This is done as follows:

    #config/application.rb
    config.action_dispatch.rescue_responses["ActionController::YourError"] = :bad_request

The full list of Rails HTTP response codes can be found [here][status_codes]. The default is `bad_request` / `500`.

We have now built this functionality into `ExceptionHandler` --

    # config/application.rb
    config.exception_handler = {
      custom_exceptions = {
        "ActionController::MyError" => :bad_request
      }
    }

This just recreates the declarations in our gem.

May remove the functionality but since so many people requested it, we'll keep it for now.

---

## Support

We use `ExceptionHandler` in production, so it's imperative for us to keep it working properly.

---

**Current stable is [`0.7.5`](https://github.com/richpeck/exception_handler/releases/latest)**

### [0.7.5](https://github.com/richpeck/exception_handler/releases/tag/1.0.0)
 - [ ] HTTP-based layouts
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
  <strong>[`ExceptionHandler`](#) is now the leading custom error pages gem for Rails.</strong>
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
