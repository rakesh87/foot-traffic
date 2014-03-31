require './data_builder'

module Printer
	module_function
	def print
		DataBuilder.new.format_room_data.each{ |value| puts value }
	end

	print()
end