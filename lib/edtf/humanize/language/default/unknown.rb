# frozen_string_literal: true

module Edtf
  module Humanize
    module Language
      module Default
        module Unknown
          extend self

          def humanizer(_date)
            I18n.t('edtf.terms.unknown', default: 'unknown')
          end
        end
      end
    end
  end
end
