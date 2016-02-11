# edtf-humanize

This gem adds a humanize method to EDTF::Decade, EDTF::Interval, EDTF::Set, EDTF::Season, and Date (ISO 8601 compliant) objects.

## Examples


### Date (ISO 8601)

```
> d = Date.edtf('1975-07-01')
 => Tue, 01 Jul 1975 
> d.humanize
 => "July 1, 1975"
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
 