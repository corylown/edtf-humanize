# frozen_string_literal: true

module Edtf
  module Humanize
    module Language
      module Default
        module Set
          include Edtf::Humanize::Language::Default::Formats

          extend self

          def humanizer(date)
            format_set_entries(date).to_sentence(
              words_connector:
                I18n.t("edtf.terms.set_dates_connector_#{mode(date)}",
                       default: ', '),
              last_word_connector:
                I18n.t("edtf.terms.set_last_date_connector_#{mode(date)}",
                       default: default_word_connector(date)),
              two_words_connector:
                I18n.t("edtf.terms.set_two_dates_connector_#{mode(date)}",
                       default: default_word_connector(date))
            )
          end

          private

          def default_word_connector(date)
            mode(date) == 'inclusive' ? ' and ' : ' or '
          end

          def format_set_entries(dates)
            dates.entries.map.with_index do |date, index|
              "#{apply_if_earlier(dates, index)}"\
              "#{apply_if_later(dates, index)}"\
              "#{apply_prefix_if_approximate(date)}"\
              "#{date_format(date)}"\
              "#{apply_suffix_if_approximate(date)}"\
            end
          end

          # '[..1760-12-03]' => on or before December 3, 1760
          def apply_if_earlier(dates, index)
            return earlier_prefix(dates) if dates.earlier? && index.zero?
          end

          def earlier_prefix(dates)
            I18n.t("edtf.terms.set_earlier_prefix_#{mode(dates)}",
                   default: earlier_prefix_default(dates))
          end

          def earlier_prefix_default(dates)
            mode(dates) == 'inclusive' ? 'on and before ' : 'on or before '
          end

          # '[1760-12..]' => on or after December 1760
          def apply_if_later(dates, index)
            return later_prefix(dates) if dates.later? &&
                                          (index + 1) == dates.size
          end

          def later_prefix(dates)
            I18n.t("edtf.terms.set_later_prefix_#{mode(dates)}",
                   default: later_prefix_default(dates))
          end

          def later_prefix_default(dates)
            mode(dates) == 'inclusive' ? 'on and after ' : 'on or after '
          end

          def mode(date)
            date.choice? ? 'exclusive' : 'inclusive'
          end
        end
      end
    end
  end
end
