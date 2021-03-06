$:.push File.expand_path('../lib', __FILE__)

require 'rocket_job_mission_control/version'

Gem::Specification.new do |s|
  s.name        = 'rocketjob_mission_control'
  s.version     = RocketJobMissionControl::VERSION
  s.authors     = ['Michael Cloutier', 'Chris Lamb', 'Jonathan Whittington', 'Reid Morrison']
  s.email       = ['support@rocketjob.io']
  s.homepage    = 'http://rocketjob.io'
  s.summary     = "Ruby's missing batch system."
  s.description = 'Rocket Job Mission Control is the Web user interface to manage Rocket Job.'
  s.license     = 'Apache-2.0'

  s.files      = Dir['{app,config,db,lib,vendor}/**/*', 'LICENSE.txt', 'Rakefile', 'README.md']
  s.test_files = Dir['test/**/*']

  s.add_dependency 'rails', '>= 4.0'
  s.add_dependency 'rocketjob', '~> 4.0'
  s.add_dependency 'jquery-rails'
  s.add_dependency 'jquery-datatables-rails', '~> 3.3'
  s.add_dependency 'bootstrap-sass', '>= 3.2.0.1'
  s.add_dependency 'sass-rails', '>= 3.2'
  s.add_dependency 'access-granted', '~> 1.1'
end
