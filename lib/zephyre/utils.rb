require 'pry'
class String
	def to_snake_case
		self.gsub("::", "/").
			gsub(/([A-Z]+)([A-Z][a-z])/, '\1_\2').
			gsub(/([a-z\d])([A-Z])/, '\1_\2').
			tr("-", "_").
			downcase
	end

	def to_camel_case
		return self if self !~ /_/ && self =~ /[A-Z]+.*/

		split('_').map{ |str| str.capitalize }.join
	end
end

module Zephyre
	def self.is_environment?(environment)
		environment.to_s == ENV['RACK_ENV']
	end
end