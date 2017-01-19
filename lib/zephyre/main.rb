require "zephyre/version"
require "zephyre/controller"
require "zephyre/utils"
require "zephyre/dependencies"
require "zephyre/routing"

module Zephyre
  class Application
  	def map_routes(&block)
			@router ||= Zephyre::Router.new
			@router.instance_eval(&block)
		end

		def get_rack_app(env)
			@router.check_url(env["PATH_INFO"], env["REQUEST_METHOD"])
		end

  	def call(env)
      get_rack_app(env).call(env)
  	end
  end
end