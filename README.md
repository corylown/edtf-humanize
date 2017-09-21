# edtf-humanize


The EDTF-humanize gem adds a humanize method to EDTF::Decade, EDTF::Century, EDTF::Interval, EDTF::Set, EDTF::Season, EDTF::Unknown, and Date (ISO 8601 compliant) objects. It uses the [edtf-ruby](https://github.com/inukshuk/edtf-ruby) gem for parsing EDTF date strings into Date and EDTF objects.

See the [edtf-ruby project's documentation](https://github.com/inukshuk/edtf-ruby) for details about supported EDTF string formats and other implementation details.

This gem is used in production by Duke University Library's [digital repository](https://github.com/duke-libraries/ddr-public) to transform date metadata stored as Extended Date Time Format (EDTF) strings into human readable strings for display.


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

### I18n

TODO

## Configuration

You can configure some aspects of how dates are humanized. In a Rails application you could place the following block in an initializer to modify the default configurations. The current set of options were driven by local use cases. Please feel free to submit an issue if you have a use case not covered by the current options.

The following options are available (defaults shown).

```
Edtf::Humanize.configure do |config|
  config.day_precision_strftime_format = "%B %-d, %Y"
  config.month_precision_strftime_format = "%B %Y"
  config.year_precision_strftime_format = "%Y"
  config.approximate_date_prefix = "circa "
  config.uncertain_date_suffix = "?"
  config.decade_suffix = "s"
  config.century_suffix = "s"
  config.unspecified_digit_substitute = "x"
  config.interval_connector = " to "
  config.interval_unspecified_suffix = "s"
  config.set_dates_connector = ", "
  config.set_last_date_connector = " or "
  config.set_two_dates_connector = " or "
  config.unknown = "unknown"
end
```

