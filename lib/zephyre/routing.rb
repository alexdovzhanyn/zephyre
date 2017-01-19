module Zephyre
	class Router

		def initialize
			@routes = []

			create_http_methods
		end

		def create_http_methods
			[:get, :post, :put, :patch, :delete, :match].each do |http_method|

				self.define_singleton_method(http_method) do |pathmap|
					target = pathmap.values.first

					url_parts = pathmap.keys.first.split("/")
					url_parts.select! {|part| !part.empty?}

					placeholders = []
					regexp_parts = url_parts.map do |part|
						if part[0] == ":"
							placeholders << part[1..-1]
							"([A-Za-z0-9_]+)"
						else
							part
						end
					end

					regexp = regexp_parts.join('/')

					@routes << {
						regexp: Regexp.new("^/#{regexp}$"),
						target: target,
						placeholders: placeholders,
						method: "#{http_method.to_s.upcase}"
					}
				end
			end
		end
		
		def check_url(url, method)
			@routes.each do |route|
				match = route[:regexp].match(url)

				if (match && (route[:method] == "MATCH" || route[:method].match(method)))
					placeholders = {}

					route[:placeholders].each_with_index do |placeholder, index|
						placeholders[placeholder] = match.captures[index]
					end

					if route[:target]
						return convert_target(route[:target])
					else
						controller = placeholders["controller"]
						action = placeholders["action"]
						
						return convert_target("#{controller}.#{action}")
					end
				end
			end
		end

		def convert_target(target)
			if target =~ /^([^.]+).([^.]+)$/
				controller_name = $1.to_camel_case
				controller = Object.const_get("#{controller_name}Controller")
				return controller.action($2)
			end
		end
	end
end