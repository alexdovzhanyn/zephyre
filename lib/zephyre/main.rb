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

			puts "Zephyre has begun mining on port 9000"
		end

		def get_rack_app(env)
			# See if the url in the request has been mapped
			@router.check_url(env["PATH_INFO"], env["REQUEST_METHOD"])
		end

  	def call(env)
      get_rack_app(env).call(env)
  	end
  end
end
