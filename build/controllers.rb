module Build::Controllers

  $paths = [
    './builds/fedora-x86/',
    './builds/fedora-x86-64/',
    './builds/osx-x86-64/',
    './builds/ubuntu-x86/',
    './builds/ubuntu-x86-64/',
    './builds/win-x86/',
    './builds/win-x86-64/'
  ]
  
  def topFiles(path)
    cont = Dir.entries(path).sort_by { |f|
      File.mtime("#{path}#{f}")
    }
    cont.delete('.')
    cont.delete('..')
    cont.reverse[0..4]
  end
  
  class Index < R '/'
    def get
      @builds = Array.new
      
      $paths.each { |path|
        puts path
        build = topFile(path)
        if build && build.os
          @builds.push(build)
        end
      }
      render :index
    end
    
    private
    
    def topFile(path)
      files = Array.new
      topFiles(path).each { |f|
        puts "#{path}#{f}"
        files << BuildFile.new("#{path}#{f}")
      }
      puts files
      return files[0]
    end
  end
  
  # display last 20 builds for os and version
  class Recent < R '/recent/([^/]+)/([^/]+)'
    def get(arch_dir, platform_str)
      @builds = Array.new
      path = './builds/' + arch_dir + '/'
      count = 0
      topFiles(path).each { |f|
        count += 1
        build = BuildFile.new("#{path}#{f}")
        if build.platform_str == platform_str && count <= 2
          @builds << build
        end
      }
      render :recent
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
