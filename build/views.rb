module Build::Views

	def layout
		html {
			head { 
				title "TideSDK Continuous Integration"
				link(:rel => 'stylesheet', :href => '/stylesheets/bootstrap/css/bootstrap.min.css')
				link(:rel => 'stylesheet', :href => '/stylesheets/bootstrap/css/bootstrap-responsive.min.css')
				link(:rel => 'stylesheet', :href => '/stylesheets/style.css')
				script(:src => '/javascripts/jquery-1.7.2.min.js', :type => 'text/javascript') {}
				script(:src => '/javascripts/bootstrap-tab.js', :type => 'text/javascript') {}
				script(:src => '/javascripts/custom.js', :type => 'text/javascript') {}
			}
			body.wood {
				div(:class => 'navbar navbar-fixed-top') {
					div(:class => 'navbar-inner') {
						div.container {
							a(:class => 'brand', :href => '/') {
								img(:src => 'images/tidesdk-logo.png', :class => 'brand-img')
							}
							div(:class => 'nav-collapse collapse') {
								ul.nav
							}
						}
					}
				}
				div.row {
					div(:class => 'span8 offset2 white page-fix') {
						self << yield
					}
				}
			}
		}
	end

	def index
		h1.center {"TideSDK Continuous Builds"}
		ul(:id => 'tabs', :class => 'nav nav-tabs') {
			li.active { a(:href => '#windows') {"Windows"} }
			li { a(:href => '#mac') {"Mac OS/X"} }
			li { a(:href => '#ubuntu') {"Ubuntu"} }
			# This bit should be uncommented when we support Fedora
			# li { a(:href => '#fedora') {"Fedora"} }
		}
		div(:class => 'tab-content') {
			div(:class => 'tab-pane active', :id => 'windows') {
				table(:class => 'table table-striped table-bordered table-condensed') {
					thead {
						tr {
							th {"Version"}	
							th {"Date"}
							th {"Size"}
							th {"SHA"}
							th {"Architecture"}
							th {"OS Version"}
						}
					}
					tbody {
						@win32.each { |f|
							tr {
								td { 
									a(:href => "/builds/win-x86/#{f[5]}") { text f[0] } 
								}
								td { text f[1].strftime("%d-%m-%y") }
								td { text f[2] }
								td { text f[3] }
								td { text f[4] }
								td { text f[6] }
							}
						}
						@win64.each { |f|
							tr {
								td { 
									a(:href => "/builds/win-x86-64/#{f[5]}") { text f[0] } 
								}
								td { text f[1].strftime("%d-%m-%y") }
								td { text f[2] }
								td { text f[3] }
								td { text f[4] }
								td { text f[6] }
							}
						}
					}
				}
			}
			div(:class => 'tab-pane', :id => 'mac') {
				table(:class => 'table table-striped table-bordered table-condensed') {
					thead {
						tr {
							th {"Version"}	
							th {"Date"}
							th {"Size"}
							th {"SHA"}
							th {"Architecture"}
							th {"OS Version"}
						}
					}
					tbody {
						@osx.each { |f|
							tr {
								td { 
									a(:href => "/builds/osx-x86-64/#{f.filename}") { text f.version } 
								}
								td { text f.time.strftime("%d-%m-%y") }
								td { text f.size }
								td { text f.sha }
								td { text f.arch }
								td { text f.os }
							}
						}
					}
				}
			}
			div(:class => 'tab-pane', :id => 'ubuntu') {
				table(:class => 'table table-striped table-bordered table-condensed') {
					thead {
						tr {
							th {"Version"}	
							th {"Date"}
							th {"Size"}
							th {"SHA"}
							th {"Architecture"}
							th {"OS Version"}
						}
					}
					tbody {
						@ubuntu32.each { |f|
							tr {
								td { 
									a(:href => "/builds/ubuntu-x86/#{f[5]}") { text f[0] } 
								}
								td { text f[1].strftime("%d-%m-%y") }
								td { text f[2] }
								td { text f[3] }
								td { text f[4] }
								td { text f[6] }
							}
						}
						@ubuntu64.each { |f|
							tr {
								td { 
									a(:href => "/builds/ubuntu-x86-64/#{f[5]}") { text f[0] } 
								}
								td { text f[1].strftime("%d-%m-%y") }
								td { text f[2] }
								td { text f[3] }
								td { text f[4] }
								td { text f[6] }
							}
						}
					}
				}
			}
# This next bit should be uncommented when we start supporting Fedora
=begin
			div(:class => 'tab-pane', :id => 'fedora') {
				table(:class => 'table table-striped table-bordered table-condensed') {
					thead {
						tr {
							th {"Version"}	
							th {"Date"}
							th {"Size"}
							th {"SHA"}
							th {"Architecture"}
							th {"OS Version"}
						}
					}
					tbody {
						@fedora32.each { |f|
							tr {
								td { 
									a(:href => "/builds/fedora-x86/#{f[5]}") { text f[0] } 
								}
								td { text f[1].strftime("%d-%m-%y") }
								td { text f[2] }
								td { text f[3] }
								td { text f[4] }
								td { text f[6] }
							}
						}
						@fedora64.each { |f|
							tr {
								td { 
									a(:href => "/builds/fedora-x86-64/#{f[5]}") { text f[0] } 
								}
								td { text f[1].strftime("%d-%m-%y") }
								td { text f[2] }
								td { text f[3] }
								td { text f[4] }
								td { text f[6] }
							}
						}
					}
				}
			}
=end
		}
	end
end
