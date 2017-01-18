require "zephyre/version"
require "zephyre/controller"
require "zephyre/utils"
require "zephyre/dependencies"
require "zephyre/routing"

module Zephyre
  class Application
  	def call(env)
      get_rack_app(env).call(env)
  	end
  end
end