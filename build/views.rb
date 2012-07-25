module Build::Views

  def layout
    html {
      head { 
        title "TideSDK Nightly Builds"
        meta(:'http-equiv' => 'Content-Type', :content => 'text/html; charset=utf-8')
        #link(:rel => 'stylesheet', :href => '/stylesheets/bootstrap/css/bootstrap.min.css')
        #link(:rel => 'stylesheet', :href => '/stylesheets/bootstrap/css/bootstrap-responsive.min.css')
        link(:href => '/stylesheets/main.css', :type =>'text/css', :rel => 'stylesheet', :media => 'screen')
      }
      body {
        div(:class => 'wrapper') {
           div(:class => 'logo') {'nightly builds'}
           self << yield
        }
      }
    }
  end
  
  def index
    table(:class => 'table table-striped table-bordered table-condensed') {
      index = true
      thead {
        _table_header(index)
      }
      tbody {
        @builds.each { |build|
          _build(build, index)
        }
      }
    }
  end
  
  def recent
    table(:class => 'table table-striped table-bordered table-condensed') {
      index = false  # secondary view
      thead {
        _table_header(index)
      }
      tbody {
        @builds.each { |build|
          _build(build, index)
        }
      }
    }
    p {
      a(:class => 'home', :href => '/') { 'home &rarr;' }
    }
  end
  
  # partials
  
  def _table_header(index)
    tr {
      th {'&nbsp;'}
      th {'Build Version'} 
      th {'Platform'} 
      th {'Arch'}
      th {'Commit'}
      th {'Date'}
      th {'Size'}
      th {'Download'}
      if index
        th {'More'}
      end
    }
  end
  
  def _build(build, index)
    tr {
      case build.platform_name
      when 'osx'
        td {
          i(:class => 'mac') { 'Mac' }
        }
      when 'ubuntu'
        td {
          i(:class => 'lin') { 'Ubuntu' }
        }
      when 'windows'
        td {
          i(:class => 'win') { 'Windows' }
        }
      else
        td {}
      end
      
      td { text build.version }
      td { text build.platform }
      td { text build.arch }
      td { text build.sha }
      td { text build.relative_time }
      td { text build.size }
      td {
        if index
          a(:class => 'dl', :type => 'button', :href => build.download) { 'Download' }
        else
          a(:class => 'dl', :href => '../../' + build.download) { 'Download' }
        end
      }
      if index
        td { 
          a(:href => '/recent/' + build.arch_dir + '/' + build.platform_str) { 'All recent builds' }
        }
      end
    }
  end

end
