# frozen_string_literal: true

source 'https://rubygems.org'

gemspec

gem 'rake', '~> 13.1'
gem 'rspec', '~> 3.13'
gem 'rubocop', '~> 1.92'
gem 'rubocop-rake', '~> 0.7'
gem 'rubocop-rspec', '~> 3.10'

# The CI "minimums" job tests against the oldest supported versions
if ENV['MINIMUM_VERSIONS']
  gem 'activesupport', '~> 6.1.0'
  gem 'concurrent-ruby', '< 1.3.5' # activesupport 6.1 relies on it to load Logger
  gem 'edtf', '~> 3.1.0'
end
