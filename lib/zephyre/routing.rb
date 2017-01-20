module Zephyre
	class Router

		def initialize
			@routes = []

			create_http_methods
		end

		def create_http_methods
			# Loop through http methods and create a class method for all of them
			[:get, :post, :put, :patch, :delete, :match].each do |http_method|

				self.define_singleton_method(http_method) do |pathmap|
					target = pathmap.values.first

					url_parts = pathmap.keys.first.split("/")
					url_parts.select! {|part| !part.empty?}

					placeholders = []
					regexp_parts = url_parts.map do |part|
						# Is this a parameter? If so, remember it for later
						if part[0] == ":"
							placeholders << part[1..-1]
							"([A-Za-z0-9_]+)"
						else
							part
						end
					end

					regexp = regexp_parts.join('/')

					@routes << {
						regexp: Regexp.new("^/#{regexp}$"), # Define a regex pattern to match against later
						target: target, # The controller and action defined in the route mapping
						placeholders: placeholders, # Any placeholders, like /:id
						method: "#{http_method.to_s.upcase}" # The http verb that was defined for this route
					}
				end
			end
		end
		
		def check_url(url, method)
			if url.split("/")[1] != "assets"
				# Loop through each of the defined routes and match it against the current requested URL
				@routes.each do |route|
					match = route[:regexp].match(url)

					# Did we match BOTH the correct route AND request method?
					if (match && (route[:method] == "MATCH" || route[:method].match(method)))
						placeholders = {}

						route[:placeholders].each_with_index do |placeholder, index|
							placeholders[placeholder] = match.captures[index]
						end

						# If the user defined a controller method for this route, find the associated controller and method
						if route[:target]
							return convert_target(route[:target])
						else
							# If they didn't this is a MATCH method, so find the controller and action we've parsed from the request url
							controller = placeholders["controller"]
							action = placeholders["action"]
							
							return convert_target("#{controller}.#{action}")
						end
					end
				end
			else
				return find_asset(url)
			end
		end

		# Return find a requested controller, require it as a dependency, and call the defined action
		def convert_target(target)
			if target =~ /^([^.]+).([^.]+)$/
				controller_name = $1.to_camel_case
				controller = Object.const_get("#{controller_name}Controller")
				return controller.action($2)
			end
		end

		def find_asset(url)
			filename = File.join(Dir.pwd, "app", "assets", url.split("/assets/").last)

			if File.file?(filename)
				content_type = get_content_type(filename.split(".").last)

				return -> (env) { Rack::Response.new(File.read(filename), 200, {"Content-Type" => content_type}) }
			else
				return -> (env) { Rack::Response.new("File Not Found", 404, {"Content-Type" => "text"}) }
			end
		end

		def get_content_type(extension)
			types = {
				css: "text/css",
				js: "application/javascript",
				png: "image/png",
				jpg: "image/jpg",
				jpeg: "image/jpg",
				svg: "image/svg+xml"
			}

			return types[extension.to_sym]
		end
	end
end