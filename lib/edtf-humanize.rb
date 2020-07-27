# frozen_string_literal: true

require 'edtf/humanize'

I18n.load_path +=
  Dir.glob(File.dirname(__FILE__) + '/../config/locales/*.{rb,yml}')
