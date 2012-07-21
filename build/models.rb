module Build::Models
	class BuildFile
		attr_accessor :version, :size, :filepath, :filename, :os, :arch, :sha, :time
		def initialize(file_path)
			@filename = File.basename(file_path)
			@filepath = file_path
			@version = /TideSDK-([^-]+)-.*/.match(@filename)[1]
			@time = File.mtime(file_path)
			@size = (File.size(file_path)/(1024.0**2.0)).round.to_s + "MB"
			@os = /TideSDK-[^-]+-[^-]+-(.*)-[^-]+-[^\.]+/.match(@filename)[1]
			@arch = /TideSDK-.*-([^\.]+-[^\.]+)/.match(@filename)[1]
			@sha = /TideSDK-[^-]+-([^-]+)-.*/.match(@filename)[1]
		end
	end
end
