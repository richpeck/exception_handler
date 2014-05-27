# CustomErrorPages

Rails gem to create **custom error pages** (adapted from [this tutorial](https://gist.github.com/wojtha/8433843))

Works with the [`config.exceptions_app`](http://guides.rubyonrails.org/configuring.html#rails-general-configuration) hook in Rails' middleware stack:

```config.exceptions_app sets the exceptions application invoked by the ShowException middleware when an exception happens. Defaults to ActionDispatch::PublicExceptions.new(Rails.public_path).```


---------

## Installation

Add this line to your application's Gemfile:

    gem 'custom_error_pages'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install custom_error_pages

---------

## Usage

###Dev

	#config/environments/development.rb
	config.consider_all_requests_local = false # true

`config.exceptions_app` is used in Rails' production environment. Therefore, if you wish to test the gem in dev,
you'll need to make your app process requests as `production` for now. This is a temporary step, and will be
resolved in a new version

###Production

    No action required


--------

## Contributing

1. Fork it ( https://github.com/richpeck/custom_error_pages/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
