![Exception Handler](/readme/title.jpg "Exception Handler Logo")

<p align="center">
  <strong><a href="#user-content-install">Install</a></strong> - <strong><a href="#user-content-config">Config</a></strong> - <strong><a href="#user-content-support">Support</a></strong>
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
  <img src="/readme/branded/tsla.jpg" width="425" title="Fully Branded Error Pages" /> <img src="/readme/branded/tsla.jpg" width="425" title="Fully Branded Error Pages" />
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
  <img src="/readme/check_02.png" height="22" title="Rails 4 & 5 Compatible"   align="absmiddle" />&nbsp; <strong>FULLY Rails 4 & 5 Compatible</strong> &nbsp;
</p>

Brand new `controller`, `middleware` & options have made **`ExceptionHandler`** even more powerful & efficient. Now you can use `ExceptionHandler` directly with a single click -- **plug and play** custom exception pages:

<div align="center">
  <img src="/readme/400.jpg" title="400 Errors" width="435" />
  <img src="/readme/500.jpg" title="500 Errors" width="435" />
</div>

**ExceptionHandler** uses `config.exceptions_app` to catch & send errors to the [`exceptions` controller](app/controllers/exception_handler/exception_controller.rb).

It uses data stored in `Rack` (`message`, `details`, `user agent`) to populate its `custom view`. This gives you the ability to **maintain your branding** *even* when your app experiences an exception.

----

<p align="center">
  <br />
  <img src="/readme/titles/middleware.jpg" title="Middleware Powered Exceptions" width="300" />
  <br />
</p>

The power of **`ExceptionHandler`** lies in its capacity to access the [**`ActiveDispatch::ShowExceptions`**](https://github.com/rails/rails/blob/4-0-stable/actionpack/lib/action_dispatch/middleware/show_exceptions.rb) middleware:

<p align="center">
  <img src="/readme/middleware.jpg" title="Exceptions handled by the ActiveDispatch::ShowExceptions Middleware" />
</p>

Rails invokes [`config.exceptions_app`](http://guides.rubyonrails.org/configuring.html#rails-general-configuration) whenever an exception is raised.

**ExceptionHandler** injects our `ExceptionController` into this hook to provide the most efficient response:

> **`config.exceptions_app`** sets the exceptions application invoked by the **`ShowException`** middleware when an exception happens. Defaults to **`ActionDispatch::PublicExceptions.new(Rails.public_path)`**.

<p align="center">
  <img src="readme/exceptions_app.jpg" title="Exceptions App" />
</p>

As opposed to other exception suites (which use the `routes`), this gives you DIRECT access to the exception through the middleware stack, straight to the [`ExceptionController`](/app/controllers/exception_handler/exception_controller.rb):

<p align="center">
  <img src="readme/controller_middleware.jpg" title="ExceptionsController compiles the exception & delivers to the front-end" />
</p>

**ExceptionHandler** uses [custom middleware](https://github.com/richpeck/exception_handler/blob/0.5/lib/exception_handler/parse.rb) to extract *all* the exception data for the request. Not only is this the most succinct, efficient way to do this, it also allows you to customize the *entire* fault-recovery process.

It's completely unique - the **only** professional solution to catch, process & handle exceptions in Rails.

----------

<p align="center" id="install">
  <br />
  <img src="readme/titles/install.jpg" title="1 Click Install for ExceptionHandler 5 on Rails 5" width="350" />
  <br />
  <strong>You Don't Need <i>Any</i> Configuration To Run ExceptionHandler</strong>
</p>

    gem install "exception_handler"

or

    gem 'exception_handler', '~> 0.5.0' #-> Gemfile

`ExceptionHandler`'s new **config** system (introduced in [`0.4.7`](https://github.com/richpeck/exception_handler/wiki/Setup)) stores all the [defaults](#user-content-defaults) - you just need to install the gem & let it run.

If you want to change *any* settings (detailed [below](#user-content-config)), you **simply** need to change `config/application.rb` / `config/environments/your_env.rb`. The ***POWER*** of this *new config system* means you're able to deploy `ExceptionHandler` in the most unobtrusive, versatile way possible.

<p align="center">
  <a href="http://rubygems.org/gems/exception_handler" target="_blank">
    <img src="/readme/rubygems.jpg" title="30,000+ Downloads Through RubyGems" />
    <br />
  </a>
</p>

----

<p align="center" id="config">
  <br />
  <img src="readme/titles/config.jpg" title="Instant Custom Error Pages For Rails 4 & 5" width="325" />
</p>

**`ExceptionHandler 0.5`** has the SIMPLEST config possible...

<p align="center">
  <img src="/readme/config_defaults.jpg" title="ExceptionHandler Default Configuration Options">
</p>

The MAGIC is that it uses [`environment files`](http://guides.rubyonrails.org/configuring.html#creating-rails-environments).

You can apply the above options to any of Rails' environment files, allowing you to customize the `ExceptionHandler` gem without inducing ANY overhead. `Initializer` files just get in the way. 

> **IMPORTANT**
>
> If you're upgrading from >= `0.4.7`, you need to **remove your `exception_handler` initializer**.
> 
> We've changed the load process to use Rails app config - **you don't need the `exception_handler` initializer any more**

----

<br />
<img src="readme/titles/defaults.jpg" title="Defaults" id="defaults" />

As can be seen in the [`config class`](/lib/exception_handler/config.rb), the following are all the options `exception_handler` accepts:

<p align="center">
  <img src="/readme/defaults.jpg" title="ExceptionHandler Default Configuration Options">
</p>

    # config.rb
    DEFAULTS = {
      dev:    false, #-> defaults to "false" for dev mode
      db:     false, #-> defaults to :errors if true, else input "table_name" as string
      email:  false, #-> need to integrate
      social: {
        :facebook   =>  'frontline.utilities', #-> Facebook handle
        :twitter    =>  'frontlineutils',      #-> Twitter handle
        :youtube    =>  'frontlineutils',      #-> YouTube handle
        :linkedin   =>  'frontline-utilities', #-> LinkedIn handle
        :fusion     =>   'frontlineutils',     #-> Fusion handle
        :url => {                             
          :facebook   =>  'https://facebook.com',          #-> no need to edit
          :twitter    =>  'http://twitter.com',            #-> no need to edit
          :youtube    =>  'https://youtube.com/user',      #-> no need to edit
          :linkedin   =>  'https://linkedin.com/company',  #-> no need to edit
          :fusion     =>  'https://frontlinefusion.com',   #-> no need to edit              
        },
      },
      layouts: {
        '404' => nil, #-> 404 Callback (needs improving big time) Use the following: '404' => <<-EOF redirect_to root_url, notice: "Hello" EOF
        '400' => nil, #-> layout for 400 error code (404 should only be used as response)
        '500' => 'exception'
      },
    }

The above are ***defaults***.

You can change the options for each [`environment file`](http://guides.rubyonrails.org/configuring.html#creating-rails-environments): 

- `config/application.rb`
- `config/environments/development.rb`
- `config/environments/production.rb`
- `config/environments/staging.rb`

The benefit of this is that it gives you the ability to customize `ExceptionHandler` for any of your environments. Contrary to a shitty `initializer`, you're able to sculpt the gem to work FOR YOU. 

----

<br />
<img src="readme/titles/dev.jpg" title="Development Mode (New!!!)" id="dev" />

Want to test in the `dev` environment?

    #config/application.rb
    config.exception_handler = {
      dev: true # -> Runs in development mode WITHOUT changing the app environment files
    }

<img src="/readme/dev.jpg" title="ExceptionHandler Dev Mode - NEW!!!!!">

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

<br />
<img src="readme/titles/view.jpg" title="Views" id="view" />

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

<br />
<img src="readme/titles/db.jpg" title="Database" id="db" />

If you want to store exceptions in your `db`, you will need to set up a **migration**:

    $ rails generate exception_handler:migration
    $ rake db:migrate

You will also need to ensure your config db option is either `true` or `"table_name"`:

<img src="/readme/db.jpg" title="ExceptionHandler DB Config">

<img src="/readme/db_screenshot.jpg" title="ExceptionHandler Database">

> **IMPORTANT**
> 
> `ExceptionHandler`'s [new config system](https://github.com/richpeck/exception_handler/wiki/Setup) is `environment` agnostic. 
> 
> **Where you declare your `db` setting will change depending on your environment**
> 
> If you declare `db` in `application.rb`, it will be applicable for all `environments`; only declaring in `production.rb` will set it for production *only*.

----

<p align="center" id="support">
  <br />
  <img src="readme/titles/support.jpg" title="1hr & 24 hr Support" width="225" />
</p>

Github Issue (1hr) | Stackoverflow (24hrs)
:----: | :----:
[![StackOverflow](/readme/github.jpg)](https://github.com/richpeck/exception_handler/issues) | [![StackOverflow](/readme/stackoverflow.jpg)](http://stackoverflow.com/questions/ask?tags=ruby-on-rails+exception-handler)

We use **`ExceptionHandler`** in production, so we have a vested interest in keeping it running smoothly.

Asking in either of the above services will give you a response. Don't be shy, we want to make this the best `exception handling` middleware for Rails.

--

<br />
<img src="readme/titles/changelog.jpg" title="Changelog" id="changelog" />

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

&copy; 2016 [**Richard Peck**](http://stackoverflow.com/users/1143732/richard-peck) for [**FL**](http://frontlineutilities.co.uk)