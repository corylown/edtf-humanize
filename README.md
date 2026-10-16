# edtf-humanize

[![CI](https://github.com/corylown/edtf-humanize/actions/workflows/ci.yml/badge.svg)](https://github.com/corylown/edtf-humanize/actions/workflows/ci.yml)

edtf-humanize turns [Extended Date/Time Format (EDTF)](https://www.loc.gov/standards/datetime/) dates into human-readable strings, in English, French, German and Italian:

```ruby
Date.edtf('1984~/2004-06').humanize # => "circa 1984 to June 2004"
```

It adds a `humanize` method to `Date` and to the `EDTF::Century`, `EDTF::Decade`, `EDTF::Interval`, `EDTF::Season`, `EDTF::Set` and `EDTF::Unknown` objects that the [edtf-ruby](https://github.com/inukshuk/edtf-ruby) gem parses. See edtf-ruby's documentation for the EDTF syntax it supports.

## Requirements

- Ruby 3.1 or later
- [edtf](https://rubygems.org/gems/edtf) 3.1 or later
- ActiveSupport 6.1 or later

On Ruby 4.0, if nothing else in your bundle depends on `racc` (Rails apps usually get it through nokogiri), add `gem 'racc'` to your Gemfile. edtf needs it but doesn't declare it ([inukshuk/edtf-ruby#50](https://github.com/inukshuk/edtf-ruby/issues/50)).

## Installation

Add the gem to your Gemfile and run `bundle install`:

```ruby
gem 'edtf-humanize'
```

Or install it directly with `gem install edtf-humanize`. Outside Rails, require it with:

```ruby
require 'edtf-humanize'
```

## Examples

Parse an EDTF string with `Date.edtf` and call `humanize` on the result.

### Dates

| EDTF | `humanize` |
|---|---|
| `1975-07-01` | July 1, 1975 |
| `1975-07` | July 1975 |
| `1975` | 1975 |
| `1981~` | circa 1981 |
| `1981?` | 1981? |
| `1981%` | circa 1981? |
| `2004-06~-11` | circa June 11, 2004 |

### Unspecified digits

| EDTF | `humanize` |
|---|---|
| `198X` | 1980s (year unknown) |
| `19XX` | 20th century (year unknown) |
| `198X-05` | May, 1980s (year unknown) |
| `1990-XX` | 1990 (month unknown) |
| `1990-05-XX` | May 1990 (day unknown) |

### Decades and centuries

| EDTF | `humanize` |
|---|---|
| `197x` | 1970s |
| `19xx` | 20th century |

A lowercase `x` and an uppercase `X` mean different things:

- **`197x` is a decade:** the whole span, 1970 through 1979. edtf-ruby parses it as an `EDTF::Decade` (`19xx` as an `EDTF::Century`).
- **`197X` is one unknown year:** a single year whose last digit isn't known. edtf-ruby parses it as a `Date` with an unspecified digit, so it renders as "1970s (year unknown)".

### Seasons

| EDTF | `humanize` |
|---|---|
| `1975-22` | summer 1975 |
| `1975-22~` | circa summer 1975 |

### Intervals

| EDTF | `humanize` |
|---|---|
| `1981/1985` | 1981 to 1985 |
| `1984~/2004-06` | circa 1984 to June 2004 |
| `1985/199X` | 1985 to 1990s (year unknown) |
| `1990-XX/1991` | 1990 (month unknown) to 1991 |
| `1980/open` | since 1980 |
| `unknown/1980` | unknown date to 1980 |

### Sets

| EDTF | `humanize` |
|---|---|
| `[1888, 1889, 1891]` | 1888, 1889 or 1891 |
| `{1888, 1889}` | 1888 and 1889 |
| `[..1760-12-03]` | on or before December 3, 1760 |
| `[1760-12..]` | on or after December 1760 |

### Unknown dates

| EDTF | `humanize` |
|---|---|
| `XXXX` | unknown |

## Internationalization

Output follows the current `I18n.locale`. The supported locales are `:en`, `:fr`, `:de` and `:it`:

| EDTF | `:fr` |
|---|---|
| `1975-24` | hiver 1975 |
| `20xx` | XXIe siècle |
| `198X` | Les années 1980 (année inconnue) |
| `198X/199X` | Des années 1980 (année inconnue) aux années 1990 (année inconnue) |

### Setting the locale

Set the locale globally or for a block:

```ruby
I18n.locale = :de
Date.edtf('1975-07-01').humanize # => "1. Juli 1975"

I18n.with_locale(:fr) { Date.edtf('1975-07-01').humanize } # => "1 Juillet 1975"
```

Setting any other locale raises `I18n::InvalidLocale` unless you provide translations for it (see [Adding a language](#adding-a-language)).

### Using outside Rails

No extra setup is needed. `require 'edtf-humanize'` adds the gem's locale files to `I18n.load_path`:

```ruby
require 'edtf-humanize'

I18n.locale = :it
Date.edtf('1975-22').humanize # => "estate 1975"
```

Require `edtf-humanize`, not `edtf/humanize`. The latter loads the code without the locale files, so setting a non-English locale raises `I18n::InvalidLocale: :fr is not a valid locale`.

### Customizing terms

Most wording comes from the I18n keys in [`config/locales`](config/locales). To change a term, add your own locale file to `I18n.load_path` after requiring the gem; later files take precedence:

```yaml
# config/locales/my_overrides.en.yml
en:
  edtf:
    terms:
      approximate_date_prefix_year: "about "
```

```ruby
I18n.load_path << 'config/locales/my_overrides.en.yml'
I18n.reload! # only needed if translations were already used

Date.edtf('1981~').humanize # => "about 1981"
```

Some language-specific wording, such as century names ("20th century", "XXe siècle"), is built in each language's module rather than read from I18n.

## Adding a language

Pull requests adding languages are welcome. A new language needs:

- a module in `lib/edtf/humanize/language/` that includes `Edtf::Humanize::Language::Default` and overrides what the language needs (see [`french.rb`](lib/edtf/humanize/language/french.rb))
- a locale file in [`config/locales`](config/locales) (see [`fr.edtf.yml`](config/locales/fr.edtf.yml))
- an entry for the locale in `Configuration` in [`lib/edtf/humanize.rb`](lib/edtf/humanize.rb)
- a spec file (see [`humanize_fr_spec.rb`](spec/edtf/humanize_fr_spec.rb))

## Development

Tests use RSpec and style is enforced with RuboCop. Run both with:

```bash
bundle exec rake
```
