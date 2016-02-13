# edtf-humanize

This gem adds a humanize method to EDTF::Decade, EDTF::Century, EDTF::Interval, EDTF::Set, EDTF::Season, and Date (ISO 8601 compliant) objects.

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

## Configuration

You can modify some aspects of how dates are humanized. The following options are available (defaults shows).

```
> Edtf::Humanize.configure do |config|
>   day_precision_strftime_format = "%B %-d, %Y"
>   month_precision_strftime_format = "%B %Y"
>   year_precision_strftime_format = "%Y"
>   approximate_date_prefix = "circa "
>   uncertain_date_suffix = "?"
>   decade_suffix = "s"
>   century_suffix = "s"
>   unspecified_digit_substitute = "x"
>   interval_connector = " to "
>   interval_unspecified_suffix = "s"
>   set_dates_connector = ", "
>   set_last_date_connector = " or "
>   set_two_dates_connector = " or "
> end
```
 