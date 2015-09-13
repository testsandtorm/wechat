require 'yaml'
require 'rest-client'
require './lib/client'

require './lib/globals'
Dir.glob('lib/tasks/*.rake').each do |rakefile|
    load rakefile
end

task :default do
  puts "Help message."
end
