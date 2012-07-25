$:.unshift '/home/tidesdk/tidesdk-nightly.multipart.net'
ENV['GEM_PATH'] = '/home/tidesdk/.gems:/usr/lib/ruby/gems/1.8'
ENV['GEM_HOME'] = '/home/tidesdk/.gems'

require 'rubygems'
require 'camping'
require 'action_view'
require 'rack'
require 'build'


require './build/models'
require './build/views'
require './build/controllers'

run Build
