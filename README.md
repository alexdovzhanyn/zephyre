[![Gem Version](https://badge.fury.io/rb/zephyre.svg)](https://badge.fury.io/rb/zephyre)

# Zephyre

[![zephyre.png](https://s23.postimg.org/myvid41bv/zephyre.png)](https://postimg.org/image/ynzi12saf/)

Zephyre is an opinionated ruby MVC framework that makes it easy to build small-scale projects. 

### Who should use Zephyre?

Anyone who is looking for an MVC framework that is lighter than Rails, but still has enough helpers and abstraction that you can spend time building your app.
I wouldn't recommend using Zephyre in a production environment because it simply is not developed enough to be used for production. Zephyre is built for small
applications and prototyping. Keep in mind that if you DO decide to use Zephyre, you should be comfortable with potentially breaking updates, as the framework
will be going through iterations and changes often in its early stages.

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

### Setup

Setting up a new project with zephyre is easy. Just go to your desired directory and run:
		
    $ zephyre claim your_project_name

This will set up a new zephyre project for you in the directory you're in. Next, `cd` into the directory zephyre generated for you, and run:
		
    $ zephyre server

This will start the server, and you'll be able to view your new project at localhost:9000


### Routing
Routing is handled in the config.ru file. The templating engine supported is currently only ERB. 
Routes are mapped by pointing a url towards an action in a controller. The following are all valid routes:

```ruby
get '/' => 'Application.an_action'
get '/:parameter1/:parameter2' => 'Another.some_action'
post '/helloworld' => 'Whatever.some_method_that_does_something'
match '/:controller/:action' => 'Application.action' # This catches all routes fitting the pattern and routes it to the specified action
```

The current supported HTTP verbs are: get, put, patch, post, and delete. Another method for matching routes is :match, which matches all routes with a specific pattern.

### Controllers

In your controller, you must explicitly define what to render. If you don't define what you want Zephyre to render, it will look for a file with the name of the action and render that file.

```ruby
class ApplicationController < Zephyre::Controller

	def index
		"This is some string" # This will render the file 'views/application/index.erb' if it is present
	end

	def other_endpoint
		render "This is some string" # This will render the string "This is some string"
	end

	def yet_another_endpoint
		render 'index' # This will render 'views/application/index.erb'
	end

	def a_hash
		render {my_key: "my value", my_other_key: "my other value"} # This will produce an error
	end

	def correct_hash_render
		render({my_key: "my value", my_other_key: "my other value"}) # This will render a stringified version of the hash
	end

end
```

Any instance variables defined within an action will be available for the view to use. For example, if you have a controller action that looks like:

```ruby
def some_action
	@name = "John Snow"

	render 'whats_my_name'
end
```

You'll be able to use the variable in `whats_my_name.erb` like so:

```erb
<p>Your name is <%= @name %></p>
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/alexdovzhanyn/zephyre. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.


## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).

