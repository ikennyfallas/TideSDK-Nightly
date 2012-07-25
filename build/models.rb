include ActionView::Helpers::DateHelper

module Build::Models
  class BuildFile
    attr_accessor :filename, :filepath,  :version, :platform_str, 
      :platform_name, :platform_version, :platform, :os,
      :arch, :arch_dir, :sha, :size, :download, :recent, :time, :relative_time
    
    def initialize(file_path)
      @filename = File.basename(file_path) 
      @filepath = file_path
      @version = /(TideSDK-[^-]+)-.*/.match(@filename)[1]
      
      @platform_str = /TideSDK-[^-]+-[^-]+-(.*)-[^-]+-[^\.]+/.match(@filename)[1]
      @platform_name = @platform_str.split('-')[0]
      if @platform_name == 'osx'
        platform_display_name = @platform_name.upcase
      else
        platform_display_name = @platform_name.capitalize
      end
      @platform_version = @platform_str.split('-')[1]
      @platform = platform_display_name + ' ' + @platform_version
      
      @os = @platform.split('-')[0]
      @arch = /TideSDK-.*-([^\.]+-[^\.]+)/.match(@filename)[1]
      @arch_dir = file_path.split('/')[2]
      @sha = /TideSDK-[^-]+-([^-]+)-.*/.match(@filename)[1]
      @size = (File.size(file_path)/(1024.0**2.0)).round.to_s + "MB"
      @download = file_path
      @recent = /TideSDK-([^-]+)-.*/.match(@filename)[1]
      @time = File.mtime(file_path)
    end
    
    def relative_time
      lambda{ return distance_of_time_in_words_to_now(@time) << " ago" }.call
    end
    
  end
end