# frozen_string_literal: true

$LOAD_PATH.push File.expand_path('lib', __dir__)

# Maintain your gem's version:
require 'edtf/humanize/version'

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = 'edtf-humanize'
  s.version     = Edtf::Humanize::VERSION
  s.authors     = ['Cory Lown']
  s.email       = ['corylown@stanford.edu']
  s.homepage    = 'https://github.com/corylown/edtf-humanize'
  s.summary     = 'This gem adds a humanize method to EDTF dates.'
  s.description = 'This gem adds a humanize method to EDTF::Decade, ' \
                  'EDTF::Interval, EDTF::Set, EDTF::Season, EDTF::Unknown, ' \
                  'and Date (ISO 8601 compliant) objects.'
  s.license     = 'BSD-3-Clause'
  s.required_ruby_version = '>= 2.4', '< 4'

  s.files = Dir['{app,config,db,lib}/**/*', 'LICENSE.txt', 'README.rdoc']
  s.test_files = Dir['spec/**/*']

  s.add_dependency 'activesupport', '>= 4'
  s.add_dependency 'edtf', '>= 2.3', '< 4'
  s.add_dependency 'roman', '~> 0.2.0'

  s.add_development_dependency 'rake', '~> 13.0'
  s.add_development_dependency 'rspec', '~> 3.9'
  s.add_development_dependency 'rubocop', '~> 0.87'
  s.add_development_dependency 'rubocop-rspec', '~> 1.39'
end
