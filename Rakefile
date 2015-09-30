require 'active_support'
require 'active_support/core_ext'

require 'dotenv'

Dotenv.load "#{File.dirname(File.expand_path(__FILE__))}/.env"

require './lib/github_adapter'
require './lib/google_adapter'

Rake.add_rakelib 'lib/tasks'

task default: :ping


desc 'Start console.'
task :console do
  require 'pry'
  require 'awesome_print'
  Pry.start
end
