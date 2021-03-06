require './file_reader'
class DataBuilder
	include FileReader

	def build_raw_data
		raw_data = []
		read_file.each_line do |line|
			data_per_line = line.split(' ')
			raw_data << data_per_line
		end
		raw_data
	end

  def convert_raw_data
  	raw_data = build_raw_data
  	number_of_line = raw_data.shift
  	data_with_key_value = Hash.new { |h,k| h[k] = [] }

  	raw_data.each do |data|
  		data.insert(1, data.shift)
  		data_with_key_value[data.shift] << data
  	end

  	data_with_key_value
  end

  def narrow_data_set
  	per_room_data = {}

  	convert_raw_data.each do |key, value|
  		person_data = Hash.new { |h,k| h[k] = [] }
  		value.each do |data|
  			person_id = data.shift
  			person_data[person_id] << Hash[*data]
  		end
  		per_room_data[key] = person_data
  	end

  	per_room_data.sort_by{|k, v| k.to_i}
  end

  def avg_time(time, room_data_size)
  	time.inject(0, :+) / room_data_size
  end

	def display_string(room_name, time, room_data_size)
  	"Room #{room_name}, #{avg_time(time, room_data_size)} minute average visit, #{room_data_size} visitor(s) total"
  end
  
  def format_room_data
  	room_foot_print_string_collection = []
  	narrow_data_set.each do |key, value|
  		time = []
  		value.each do |k, v|
  			person_data = v
  			person_data.reduce{ |a, data| a.merge! data}
  			in_time = person_data.first.fetch('I').to_i
  			out_time = person_data.first.fetch('O').to_i
  			total_time = out_time - in_time
  			time << total_time
  		end
  		room_foot_print_string_collection << display_string(key, time, value.size)
  	end
  	room_foot_print_string_collection
  end


end