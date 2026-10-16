# edtf-humanize

[![CI](https://github.com/corylown/edtf-humanize/actions/workflows/ci.yml/badge.svg)](https://github.com/corylown/edtf-humanize/actions/workflows/ci.yml)

The EDTF-humanize gem adds a humanize method to EDTF::Decade, EDTF::Century, EDTF::Interval, EDTF::Set, EDTF::Season, EDTF::Unknown, and Date (ISO 8601 compliant) objects. It uses the [edtf-ruby](https://github.com/inukshuk/edtf-ruby) gem for parsing EDTF date strings into Date and EDTF objects.

See the [edtf-ruby project's documentation](https://github.com/inukshuk/edtf-ruby) for details about supported EDTF string formats and other implementation details.

This gem is used in production by Duke University Library's [digital repository](https://gitlab.oit.duke.edu/ddr/ddr-xenon/) to transform date metadata stored as Extended Date Time Format (EDTF) strings into human readable strings for display.


## Installation

In a Rails application using Bundler

Add the following to your Gemfile:

```
gem 'edtf-humanize'
```

Then run:

```
> bundle install
```

To use in other contexts install the gem and require it:

```
> gem install edtf-humanize
```

```
require 'edtf-humanize'
```


## Examples


### Date (ISO 8601)

```
> d = Date.edtf('1975-07-01')
 => Tue, 01 Jul 1975
> d.humanize
 => "July 1, 1975"
> d = Date.edtf('1981~')
 => Thu, 01 Jan 1981
> d.humanize
 => "circa 1981"
> d = Date.edtf('198u')
 => Tue, 01 Jan 1980
> d.humanize
 => "198x"
 ```

### EDTF::Season

```
> d = Date.edtf('1975-22')
 => #<EDTF::Season:0x0000000b6dd980 @year=1975, @season=:summer, @qualifier=nil>
> d.humanize
 => "summer 1975"
 ```

### EDTF::Decade

 ```
> d = Date.edtf('197x')
 => #<EDTF::Decade:0x0000000b6fe798 @year=1970>
> d.humanize
 => "1970s"
 ```

### EDTF::Century

 ```
> d = Date.edtf('19xx')
 => #<EDTF::Century:0x0000000b6fe798 @year=1900>
> d.humanize
 => "1900s"
 ```

### EDTF::Interval

 ```
> d = Date.edtf('1981/1985')
 => #<EDTF::Interval:0x0000000ceeab18 @from=Thu, 01 Jan 1981, @to=Tue, 01 Jan 1985>
> d.humanize
 => "1981 to 1985"
 ```

### EDTF::Set

 ```
> d = Date.edtf('[1888, 1889, 1891]')
 => #<EDTF::Set:0x0000000cef5450 @dates=#<Set: {Sun, 01 Jan 1888, Tue, 01 Jan 1889, Thu, 01 Jan 1891}>, @choice=true, @later=false, @earlier=false>
> d.humanize
 => "1888, 1889 or 1891"
 ```

### EDTF::Unknown

```
> d = Date.edtf('uuuu')
 => #<EDTF::Unknown:0x0000000c04c688 @d=1>
> d.humanize
 => "unknown"
```

## Internationalization

EDTF-humanize supports the use of I18n as well as language specific module overrides for more nuanced control. English, French, German, and Italian are supported.

Examples with current locale `:fr`:

```
> Date.edtf('1975-24').humanize
 => "hiver 1975"
 > Date.edtf('20xx').humanize
 => "XXIe siècle"
```

### Setting the locale

`humanize` uses the current `I18n.locale`. Set it globally or for a block:

```ruby
I18n.locale = :de
Date.edtf('1975-07-01').humanize # => "1. Juli 1975"

I18n.with_locale(:fr) { Date.edtf('1975-07-01').humanize } # => "1 Juillet 1975"
```

The supported locales are `:en`, `:fr`, `:de` and `:it`. Setting any other locale raises `I18n::InvalidLocale` unless you provide translations for it (see below).

### Using outside Rails

No extra setup is needed beyond requiring the gem. `require 'edtf-humanize'` adds the gem's locale files to `I18n.load_path`:

```ruby
require 'edtf-humanize'

I18n.locale = :it
Date.edtf('1975-22').humanize # => "estate 1975"
```

Require `edtf-humanize`, not `edtf/humanize`. The latter loads the code without the locale files, so setting a non-English locale raises `I18n::InvalidLocale: :fr is not a valid locale`.

### Customizing terms

All wording comes from the I18n keys in [`config/locales`](config/locales). To change a term, add your own locale file to `I18n.load_path` after requiring the gem; later files take precedence:

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

Pull requests to add support for additional languages are welcome. You must add a new language module for the language and include the Default language module. A locales file with translations is also needed. The supporting files for French may be used as a reference for adding support for additional languages.:

```
edtf-humanize/lib/edtf/humanize.rb
edtf-humanize/config/locales/fr.edtf.yml
edtf-humanize/lib/edtf/humanize/language/french.rb
edtf-humanize/spec/edtf/humanize_fr_spec.rb
```

## Contributions

Contributions, especially to add support for additional languages are welcome. Tests are expected and written using RSpec. Code style is enforced with Rubocop.


