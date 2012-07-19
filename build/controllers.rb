module Build::Controllers

	class Index < R '/'
		def get
			#osx files
			path = './builds/osx-x86-64/'
			arch = 'x86 64-bit'
			@osx = Array.new
			topFiles(path).each { |f| @osx << [/TideSDK-([^-]+)-.*/.match(f)[1], File.mtime("#{path}#{f}"), 
				(File.size("#{path}#{f}")/(1024.0**2.0)).round(2).to_s + "MB", /TideSDK-[^-]+-([^-]+)-.*/.match(f)[1], arch, f] }

			#windows 64 files
			path = './builds/win-x86-64/'
			arch = 'x86 64-bit'
			@win64 = Array.new
			topFiles(path).each { |f| @win64 << [/TideSDK-([^-]+)-.*/.match(f)[1], File.mtime("#{path}#{f}"), 
				(File.size("#{path}#{f}")/(1024.0**2.0)).round(2).to_s + "MB", /TideSDK-[^-]+-([^-]+)-.*/.match(f)[1], arch, f] }

			#windows 32 files
			path = './builds/win-x86/'
			arch = 'x86 32-bit'
			@win32 = Array.new
			topFiles(path).each { |f| @win32 << [/TideSDK-([^-]+)-.*/.match(f)[1], File.mtime("#{path}#{f}"), 
				(File.size("#{path}#{f}")/(1024.0**2.0)).round(2).to_s + "MB", /TideSDK-[^-]+-([^-]+)-.*/.match(f)[1], arch, f] }

			#ubuntu 64 files
			path = './builds/ubuntu-x86-64/'
			arch = 'x86 64-bit'
			@ubuntu64 = Array.new
			topFiles(path).each { |f| @ubuntu64 << [/TideSDK-([^-]+)-.*/.match(f)[1], File.mtime("#{path}#{f}"), 
				(File.size("#{path}#{f}")/(1024.0**2.0)).round(2).to_s + "MB", /TideSDK-[^-]+-([^-]+)-.*/.match(f)[1], arch, f] }

			#ubuntu 32 files
			path = './builds/ubuntu-x86-64/'
			arch = 'x86 32-bit'
			@ubuntu32 = Array.new
			topFiles(path).each { |f| @ubuntu32 << [/TideSDK-([^-]+)-.*/.match(f)[1], File.mtime("#{path}#{f}"), 
				(File.size("#{path}#{f}")/(1024.0**2.0)).round(2).to_s + "MB", /TideSDK-[^-]+-([^-]+)-.*/.match(f)[1], arch, f] }
			render :index

#This bit is for Fedora support
=begin
			#fedora 64 files
			path = './builds/fedora-x86-64/'
			arch = 'x86 64-bit'
			@fedora64 = Array.new
			topFiles(path).each { |f| @fedora64 << [/TideSDK-([^-]+)-.*/.match(f)[1], File.mtime("#{path}#{f}"), 
				(File.size("#{path}#{f}")/(1024.0**2.0)).round(2).to_s + "MB", /TideSDK-[^-]+-([^-]+)-.*/.match(f)[1], arch, f] }

			#fedora 32 files
			path = './builds/fedora-x86-64/'
			arch = 'x86 32-bit'
			@fedora32 = Array.new
			topFiles(path).each { |f| @fedora32 << [/TideSDK-([^-]+)-.*/.match(f)[1], File.mtime("#{path}#{f}"), 
				(File.size("#{path}#{f}")/(1024.0**2.0)).round(2).to_s + "MB", /TideSDK-[^-]+-([^-]+)-.*/.match(f)[1], arch, f] }
=end
		end

		private

		def topFiles(path)
			cont = Dir.entries(path).sort_by { |f| File.mtime("#{path}#{f}")}
			cont.delete('.')
			cont.delete('..')
			cont.reverse[0..4]
		end
	end

	class Bootstrap < R '/stylesheets/bootstrap/css/([^/]+)'
		def get(filename)
			style = File.read("stylesheets/bootstrap/css/#{filename}")
			@headers['Content-Type'] = 'text/css; charset=utf-8'
			style
		end
	end

	class CustomStyles < R '/stylesheets/([^/]+)'
		def get(filename)
			style = File.read("stylesheets/#{filename}")
			@headers['Content-Type'] = 'text/css; charset=utf-8'
			@body = style
		end
	end

	class Javascripts < R '/javascripts/([^/]+)'
		def get(filename)
			js = File.read("javascripts/#{filename}")
			@headers['Content-Type'] = 'text/javascript; charset=utf-8'
			@body = js
		end
	end

	class Images < R '/images/([^/]+)'
		def get(filename)
			js = File.read("images/#{filename}")
			ext = filename.gsub(/([^.]*)\..+/,'')
			@headers['Content-Type'] = "image/#{ext}; charset=utf-8"
			@body = js
		end
	end

	class Builds < R '/builds/([^/]+)/([^/]+)'
		def get(dir, filename)
			file = IO.read("./builds/#{dir}/#{filename}")
			@headers['Content-Type'] = "application/zip; charset=utf-8"
			@headers['Content-Disposition'] = "attachment; filename=\"#{filename}\""
			@body = file
		end
	end
end
