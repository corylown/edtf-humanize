# frozen_string_literal: true

$LOAD_PATH.push File.expand_path('lib', __dir__)

require 'edtf/humanize/version'

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
  s.required_ruby_version = '>= 2.4'

  s.files = Dir['{config,lib}/**/*', 'LICENSE.txt', 'README.md']

  s.add_dependency 'activesupport', '>= 4'
  s.add_dependency 'edtf', '>= 2.3', '< 5'
  s.add_dependency 'roman', '>= 0.2', '< 0.4'

  s.metadata['changelog_uri'] = "#{s.homepage}/releases"
  s.metadata['rubygems_mfa_required'] = 'true'
  s.metadata['source_code_uri'] = s.homepage
end
