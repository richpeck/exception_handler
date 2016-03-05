![Exception Handler](/readme/title.jpg "Exception Handler Logo")

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
  <img src="/readme/check.png" height="22" title="Fully Responsive"               align="absmiddle" />&nbsp; Responsive &nbsp;
  <img src="/readme/check.png" height="22" title="Branded Error Pages"            align="absmiddle" />&nbsp; Branded Error Pages &nbsp;
  <img src="/readme/check.png" height="22" title="Middleware Exception Handling"  align="absmiddle" />&nbsp; Middleware Exception Handling &nbsp;
  <img src="/readme/check.png" height="22" title="Keep Users Informed"            align="absmiddle" />&nbsp; Fully Customizable &nbsp;
</p>

<p align="center">
  <img src="/readme/branded/tsla.jpg" width="425" title="Fully Branded Error Pages" /> <img src="https://d13yacurqjgara.cloudfront.net/users/13307/screenshots/2542146/iphone_game.jpg" width="425" title="Fully Branded Error Pages" />
  <img src="/readme/branded/tsla.jpg" width="425" title="Fully Branded Error Pages" /> <img src="/readme/branded/tsla.jpg" width="425" title="Fully Branded Error Pages" />
</p>

This is the most feature-rich, stable & effective solution for **custom error pages** in Rails 4 & 5.

---

<p align="center">
  <img src="https://d13yacurqjgara.cloudfront.net/users/16711/screenshots/2381757/client_present.png" title="Version 0.5" width="450" />
  <br />
  <a href="#install">Install</a> - <a href="#config">Config</a> - <a href="#support">Support</a>
</p>

**ExceptionHandler** uses `config.exceptions_app` to catch & send errors to the [`exceptions` controller](app/controllers/exception_handler/exception_controller.rb).

Tapping directly into the data stored in `Rack` (`message`, `details`, `user agent`), **ExceptionHandler** populates your own `custom view`, sending data to the DB & email notifications of the error:

<div align="center">
  <img src="/readme/400.jpg" title="400 Errors" width="435" />
  <img src="/readme/500.jpg" title="500 Errors" width="435" />
</div>

---

<p align="center">
  <br />
  <img src="/readme/titles/middleware.jpg" title="The Only Middleware-Powered Rails Exceptions Suite" />
</p>

**`ExceptionHandler`** works well because it directly harnesses the [**`ActiveDispatch::ShowExceptions`**](https://github.com/rails/rails/blob/4-0-stable/actionpack/lib/action_dispatch/middleware/show_exceptions.rb) middleware:

<p align="center">
  <img src="/readme/middleware.jpg" title="Exceptions handled by the ActiveDispatch::ShowExceptions Middleware" />
</p>

Catching exceptions through the [`config.exceptions_app`](http://guides.rubyonrails.org/configuring.html#rails-general-configuration) hook, **ExceptionHandler** invokes our `ExceptionsController` when exceptions are raised, cutting *all* overhead:

> **`config.exceptions_app`** sets the exceptions application invoked by the **`ShowException`** middleware when an exception happens. Defaults to **`ActionDispatch::PublicExceptions.new(Rails.public_path)`**.

<p align="center">
  <img src="readme/exceptions_app.jpg" title="Exceptions App" />
</p>

As opposed to other exception suites, this gives you DIRECT access to all the data which matters, straight to your own modular `ExceptionsController`:



**ExceptionHandler** uses our [custom middleware](https://github.com/richpeck/exception_handler/blob/0.5/lib/exception_handler/parse.rb) to extract *all* the exception data for the request. Not only is this the most succinct, efficient way to do this, it also allows you to customize the *entire* fault-recovery process.

It's completely unique - the **only** professional solution to catch, process & handle exceptions in Rails. Unlike other solutions - mostly directing requests to `routes` - **ExceptionHandler** sends requests directly to the controller. 

----------

30,000 users can't be wrong (Rubygems)

ExceptionHandler has been **completely reworked** for `Rails 5`:





----------

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

----------