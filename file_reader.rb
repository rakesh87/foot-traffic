module FileReader

	FILE_PATH = 'log_sample1'

	def read_file
		text=File.open(FILE_PATH).read
	end

end