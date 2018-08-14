![Exception Handler](readme/title.jpg "Exception Handler Logo")

<!-- Intro -->
<div id="intro">
  <h4 align="center"><strong><a href="https://rubygems.org/gems/exception_handler"><code>ExceptionHandler</code></a></strong> is presently the <strong>most popular exception gem</strong> for <strong><a href="https://medium.com/ruby-on-rails-web-application-development/custom-400-500-error-pages-in-ruby-on-rails-exception-handler-3a04975e4677">Rails 400/500 error pages</a></strong></h4>
  <p align="center">
    With <strong>180,000+ downloads</strong>, it is the *only* gem to provide <strong>custom exception pages for Rails 4 + 5</strong>...
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
  Following explains how it works.
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

[`ExceptionHandler`][rubygems] was designed to replace Rails' [default error pages](https://github.com/rails/rails/tree/ef0b05e78fb0b928c7ef48d3c365dc849af50305/railties/lib/rails/generators/rails/app/templates/public) with dynamic views...

<p align="center">
  <br />
  <img src="./readme/dev.png" width="85%"/>
  <br/>
  It works by injecting our own [controller](/app/controllers/exception_handler/exceptions_controller.rb) into the `exceptions_app` middlware hook.
  <br />--<br />
</p>

This hook is called by the `ActionDispatch::ShowExceptions` middleware; invoked any time an exception is raised by Rails.

This middleware wraps the erroneous exception in a valid HTTP response, and uses `exceptions_app` to populate the [HTML response body](https://en.wikipedia.org/wiki/HTTP_message_body). By default, it will pull the static HTML files stored in `/public` - we've made it pull from our own controller.

The important thing to realize about this is that you shouldn't need to change the way the system works. Our code is extremely flexible - you can use [locales][locales] to change text messages etc. Most people will only need to change the [layouts][layouts], which can be 100% customized as you require...



---

##### 📑 HTTP Error Management

If you're interested in how the system works, the most important thing is that *it doesn't matter* which errors Ruby/Rails raises - they *all* need to be wrapped in a [valid HTTP response](https://www.w3.org/Protocols/rfc2616/rfc2616-sec6.html).

Whilst HTTP has 5 categories of response code, only two are used to denote errors ([`4xx`](https://en.wikipedia.org/wiki/List_of_HTTP_status_codes#4xx_Client_errors) + [`5xx`](https://en.wikipedia.org/wiki/List_of_HTTP_status_codes#5xx_Server_errors)):

<p align="center">
  <img src="./readme/HTTP.png" width="55%" />
</p>

This means that all you're *really* doing is taking "Ruby" errors and giving them an appropriate [HTTP status code](https://en.wikipedia.org/wiki/List_of_HTTP_status_codes) & [message body](https://en.wikipedia.org/wiki/HTTP_message_body) (HTML). Rails handles the process for you - the *only* thing we need to worry about is how the HTML is generated.  

What confuses most is the way in which Rails does this.

The process is handled by [`ActionDispatch::ShowExceptions`](https://github.com/rails/rails/blob/master/actionpack/lib/action_dispatch/middleware/show_exceptions.rb#L44) - middleware which builds a new response out of the erroneous one passed to it by Rails. Through this process, it calls whichever class is present in [`exceptions_app`](http://guides.rubyonrails.org/configuring.html#rails-general-configuration)...

    # show_exceptions.rb
    def render_exception(request, exception)
      backtrace_cleaner = request.get_header "action_dispatch.backtrace_cleaner"
      wrapper = ExceptionWrapper.new(backtrace_cleaner, exception)
      status  = wrapper.status_code
      request.set_header "action_dispatch.exception", wrapper.exception
      request.set_header "action_dispatch.original_path", request.path_info
      request.path_info = "/#{status}"
      response = @exceptions_app.call(request.env) #-> this is where the HTML is generated
      response[1]["X-Cascade"] == "pass" ? pass_response(status) : response
    rescue Exception => failsafe_error
      $stderr.puts "Error during failsafe response: #{failsafe_error}\n  #{failsafe_error.backtrace * "\n  "}"
      FAILSAFE_RESPONSE
    end

In other words, what a user *sees* (in the browser) has very little to do with the error Rails experienced.

`ExceptionHandler` doesn't change this behaviour - it simply *adds* our own controller/view to provide the HTML...

---

##### ⛔️ Middleware-Powered Exceptions

The key with `ExceptionHandler` lies in its integration with the [Rack middleware stack](https://guides.rubyonrails.org/rails_on_rack.html#internal-middleware-stack).

Most other "exception" gems rely on hacking the core Rails system, our gem works *with* Rails to provide a valid set of HTML...

<p align="center">
  <img src="./readme/middleware.jpg" width="80%" />
</p>


Point is that by tapping into the `exceptions_app` middleware hook, the application is able to provide users with the ability to manage the way the system works without having to worry about whether the system is going to work with other gems etc.

The fact that it doesn't change the underlying exception handling process, or use any hacks, makes it extremely potent for production.



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

**You literally have to do nothing to get it working in production.** Just install the gem and it will provide custom 400/500 exception pages. The `4xx` pages will use your app's standard layout, `5xx` has its own [custom layout][layouts]. Both can be [customized][configuration].

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
   <a href="#config">Config</a>&nbsp;&nbsp;&nbsp;&nbsp;<a href="#dev" title="Dev Mode"> Dev</a>&nbsp;&nbsp;&nbsp;&nbsp;<a href="#database">  Database</a>&nbsp;&nbsp;&nbsp;&nbsp;<a href="#email">  Email</a>&nbsp;&nbsp;&nbsp;&nbsp;<a href="#views">Views</a>&nbsp;&nbsp;&nbsp;&nbsp;<a href="#locales"><a href="#custom-exceptions">Custom Exceptions</a>&nbsp;&nbsp;&nbsp;&nbsp;<a href="#generators">Generators</a>
</p>

----

ExceptionHandler uses the "config" file to manage the entire system.



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

Alternatively, you may wish to post on our [Github Issues](https://github.com/richpeck/exception_handler/issues), or [StackOverflow](https://stackoverflow.com/questions/tagged/ruby-on-rails+exceptionhandler).

Responses typically delivered within several hours.

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

<!-- ################################### -->
<!-- ################################### -->
