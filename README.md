[![Gem Version](https://badge.fury.io/rb/zephyre.svg)](https://badge.fury.io/rb/zephyre)

# Zephyre

[![zephyre.png](https://s23.postimg.org/myvid41bv/zephyre.png)](https://postimg.org/image/ynzi12saf/)

Zephyre is an opinionated ruby web framework that makes it easy to build small-scale projects. 

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'zephyre'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install zephyre

## Usage

Setting up a new project with zephyre is easy. Just go to your desired directory and run:
		
    $ zephyre claim your_project_name

This will set up a new zephyre project for you in the directory you're in. Next, `cd` into the directory zephyre generated for you, and run:
		
    $ zephyre server

This will start the server, and you'll be able to view your new project at localhost:9000

Routing is handled in the config.ru file. The templating engine supported is currently only ERB. 
Routes are mapped by pointing a url towards an action in a controller. The following are all valid routes:

```ruby
get '/' => 'ApplicationController.an_action'
get '/:parameter1/:parameter2' => 'AnotherController.some_action'
post '/helloworld' => 'WhateverController.some_method_that_does_something'
match '/:controller/:action' => 'ApplicationController.action' # This catches all routes fitting the pattern and routes it to the specified action
```

The current supported HTTP verbs are: get, put, patch, post, and delete. Another method for matching routes is :match, which matches all routes with a specific pattern.


## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/alexdovzhanyn/zephyre. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.


## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).

