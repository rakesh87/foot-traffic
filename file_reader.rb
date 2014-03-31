module FileReader

	FILE_PATH = 'log_sample2'

	def read_file
		text=File.open(FILE_PATH).read
	end

end