![Exception Handler](/readme/title.jpg "Exception Handler Logo")

<p align="center">
  <strong><a href="#user-content-install">Install</a> - <a href="#user-content-config">Config</a> - <a href="#user-content-support">Support</a></strong>
</p>

<p align="center">
  <a href="http://badge.fury.io/rb/exception_handler"><img src="https://badge.fury.io/rb/exception_handler.svg"></a>
  <a href="https://codeclimate.com/github/richpeck/exception_handler"><img src="https://codeclimate.com/github/richpeck/exception_handler.png"></a>
  <a href="https://gemnasium.com/richpeck/exception_handler"><img src="https://gemnasium.com/richpeck/exception_handler.svg"></a>
  <a href="https://coveralls.io/r/richpeck/exception_handler"><img src="https://coveralls.io/repos/richpeck/exception_handler/badge.png"></a>
  <a href="https://travis-ci.org/richpeck/exception_handler"><img src="https://travis-ci.org/richpeck/exception_handler.svg?branch=master"></a>
</p>

----------

**ExceptionHandler** helps you can create custom **404 & 500 production error pages** *(adapted from [**1**](https://gist.github.com/wojtha/8433843) & [**2**](http://www.sharagoz.com/posts/1-rolling-your-own-exception-handler-in-rails-3))*.

![Exceptions_App middleware](/readme/subtitle.jpg)

**ExceptionHandler** is the *only* production-ready custom error page solution for Rails 4 & 5. 

---

<p align="center">
  <br /><img src="/readme/05_title.png" width="450" /><br/>
  <strong>Customize <i>404</i> and <i>500</i> error pages to be branded to your application in production:</strong>
</p>

<p align="center">
  <img src="/readme/check.png" height="22" title="Fully Responsive"               align="absmiddle" />&nbsp; <strong>Responsive</strong> &nbsp;
  <img src="/readme/check.png" height="22" title="Branded Error Pages"            align="absmiddle" />&nbsp; <strong>Branded Error Pages</strong> &nbsp;
  <img src="/readme/check.png" height="22" title="Middleware Exception Handling"  align="absmiddle" />&nbsp; <strong>Middleware Exception Handling</strong> &nbsp;
  <img src="/readme/check.png" height="22" title="Keep Users Informed"            align="absmiddle" />&nbsp; <strong>Fully Customizable</strong> &nbsp;
</p>

<p align="center">
  <img src="/readme/branded/tsla.jpg" width="425" title="Fully Branded Error Pages" /> <img src="https://d13yacurqjgara.cloudfront.net/users/13307/screenshots/2542146/iphone_game.jpg" width="425" title="Fully Branded Error Pages" />
  <img src="/readme/branded/tsla.jpg" width="425" title="Fully Branded Error Pages" /> <img src="/readme/branded/tsla.jpg" width="425" title="Fully Branded Error Pages" />
</p>

The most feature-rich, stable & effective solution for **custom error pages** in Rails 4 & 5.

---

<p align="center">
  <img src="readme/05.jpg" title="Reworked for Rails 5" />
</p>

<p align="center">
  <img src="readme/titles/reworked.jpg" title="Reworked for Rails 5" width="450" />
</p>

<p align="center">
  <img src="/readme/check_02.png" height="22" title="New Controller"           align="absmiddle" />&nbsp; <strong>New Controller</strong> &nbsp;
  <img src="/readme/check_02.png" height="22" title="New Middleware"           align="absmiddle" />&nbsp; <strong>New Middleware</strong> &nbsp;
  <img src="/readme/check_02.png" height="22" title="Full Test Suite"          align="absmiddle" />&nbsp; <strong>Full Test Suite</strong> &nbsp;
  <img src="/readme/check_02.png" height="22" title="Rails 4 & 5 Compatible"   align="absmiddle" />&nbsp; <strong>Rails 4 & 5 Compatible</strong> &nbsp;
</p>


Brand new `controller`, `middleware` & options have made **`ExceptionHandler`** even more powerful & efficient. Now you can use `ExceptionHandler` directly with a single click -- **plug and play** custom exception pages

<p align="center">
  <img src="readme/config.png" title="Config" /> &nbsp; <img src="readme/config.png" title="Config" /> &nbsp; <img src="readme/config.png" title="Config" />
</p>

<p align="center">
  <strong><a href="#user-content-install">Install</a> - <a href="#user-content-config">Config</a> - <a href="#user-content-support">Support</a></strong>
</p>

----

# How it Works

**ExceptionHandler** uses `config.exceptions_app` to catch & send errors to the [`exceptions` controller](app/controllers/exception_handler/exception_controller.rb).

It uses data stored in `Rack` (`message`, `details`, `user agent`) to populate its `custom view`. This gives you the ability to **maintain your branding** *even* when your app experiences an exception:

<div align="center">
  <img src="/readme/400.jpg" title="400 Errors" width="435" />
  <img src="/readme/500.jpg" title="500 Errors" width="435" />
</div>

----

<p align="center">
  <br />
  <img src="/readme/titles/middleware.jpg" title="Middleware Powered Exceptions" width="300" />
  <br />
</p>

The power of **`ExceptionHandler`** lies directly in its capacity to access the [**`ActiveDispatch::ShowExceptions`**](https://github.com/rails/rails/blob/4-0-stable/actionpack/lib/action_dispatch/middleware/show_exceptions.rb) middleware:

<p align="center">
  <img src="/readme/middleware.jpg" title="Exceptions handled by the ActiveDispatch::ShowExceptions Middleware" />
</p>

Rails invokes [`config.exceptions_app`](http://guides.rubyonrails.org/configuring.html#rails-general-configuration) whenever an exception is raised.

**ExceptionHandler** injects our `ExceptionsController` into this hook to provide the most efficient response:

> **`config.exceptions_app`** sets the exceptions application invoked by the **`ShowException`** middleware when an exception happens. Defaults to **`ActionDispatch::PublicExceptions.new(Rails.public_path)`**.

<p align="center">
  <img src="readme/exceptions_app.jpg" title="Exceptions App" />
</p>

As opposed to other exception suites (which use the `routes`), this gives you DIRECT access to the exception through the middleware stack, straight to the `ExceptionsController`:

<p align="center">
  <img src="readme/config.png" title="Config" /> &nbsp;
</p>

**ExceptionHandler** uses our [custom middleware](https://github.com/richpeck/exception_handler/blob/0.5/lib/exception_handler/parse.rb) to extract *all* the exception data for the request. Not only is this the most succinct, efficient way to do this, it also allows you to customize the *entire* fault-recovery process.

It's completely unique - the **only** professional solution to catch, process & handle exceptions in Rails.

----------

<p align="center" id="install">
  <br />
  <img src="readme/titles/install.jpg" title="1 Click Install for ExceptionHandler 5 on Rails 5" width="325" />
</p>

Gemfile | Image / Rubygems / 30000
:----: | :----:

--

<p align="center" id="config">
  <br />
  <img src="readme/titles/config.jpg" title="Instant Custom Error Pages For Rails 4 & 5" width="325" />
</p>

`ExceptionHandler 0.5` has the SIMPLEST config possible...

#### Dev Mode

#### Defaults

#### Layouts

#### Views


---

<p align="center" id="support">
  <br />
  <img src="readme/titles/support.jpg" title="1hr & 24 hr Support" width="225" />
</p>

#### 0.5.1
 - Next release

#### 0.5.0
 - Added locales
 - Email notifications
 - Full test suite (finally)
 - Rails 4.2 & Rails 5.0 native ([`request.env`](https://github.com/rails/rails/commit/05934d24aff62d66fc62621aa38dae6456e276be) fix)
 - Controller fixed
 - `DB` fixed
 - Legacy initializer support ([more](https://github.com/richpeck/exception_handler/wiki/Setup))
 - Rails asset management improvement
 - Cut out most dev files from gem (drastic reduction in gem size)


#### 0.4.7

 - New config system ([more](https://github.com/richpeck/exception_handler/wiki/Setup))
 - Fixed controller layout issues
 - Streamlined middleware
 - New layout & interface implementation


----------

[FL](http://frontlineutilities.co.uk)