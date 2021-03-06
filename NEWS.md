# nasapower 1.0.0.9002

## Major changes

- Provide access to all three communities, not just AG

- Uses new NASA-POWER API to download new 1/2 x 1/2 degree data

- Replace _httr_ package with _crul_

- Add `parameters` data frame, which lists available parameters with metadata
about them

- Add function `create_met()` to create APSIM met objects from POWER data

### Deprecated functions

- `get_cell` and `get_region` are deprecated in favour of `get_power`. The new
POWER interface allows for the specification of `SinglePoint` (cell), `Regional`
(region) or `Global`. These are now arguments passed along to `get_power` for
the `type` parameter.

--------------------------------------------------------------------------------

# nasapower 0.1.4

### Bug Fixes

- Fixes bug related to date columns where `MONTH`, `DAY` and `YYYY-MM-DD` were
incorrectly reported in final data frame. This did not affect the weather data,
`YEAR` or `DOY` columns.

--------------------------------------------------------------------------------

# nasapower 0.1.3

### Bug fixes

- Fix bug where lon/lat values were improperly assigned internally due to row
names not being ordered correctly in `get_region()`

- Fix bug reports link in DESCRIPTION file

- Correct vignette where it had said, "both of which will which will download

- Correct documentation for `get_region()`, which incorrectly stated that it
downloaded data for a 1 x 1 degree cell

### Minor improvements

- Optimise arguments used in `utils::read.table()` to ingest weather data in the
`get_cell()` and `get_region()` functions more quickly

- NEWS now formatted more nicely for easier reading

- Add statement about possible performance and memory usage when using
`get_region()` in the vignette

- Add an example of converting the data frame to a spatial object using
_raster_ to create a `raster::brick()`

- Specify in documentation that a range of days to years can be specified for
download

## Minor changes

- `get_region()` and `get_cell()` now default to download all weather vars

- Add a check to see if POWER website is responding before making request for
data. If not, stop and return error message to user.

- Add new use case vignette for APSIM modelling work,
<https://adamhsparks.github.io/nasapower/articles/use-case.html>

--------------------------------------------------------------------------------

# nasapower 0.1.2

### Bug fixes

- Fixes bug where only first date is reported when using `get_region()` with
multiple dates. https://github.com/adamhsparks/nasapower/issues/1

### Minor improvements

- Enhanced documentation

- Superflous function, `.onLoad()`, removed from zzz.R

- Tidied up startup message

- Clean up vignette

- Build vignette faster

- Remove DATE from DESCRIPTION

--------------------------------------------------------------------------------

# nasapower 0.1.1

### Minor improvements

- Fix issues in documentation, typos, incorrect links, etc.

--------------------------------------------------------------------------------

# nasapower 0.1.0

### New features

* Add new functionality to download regions in addition to single cells

* Add static documentation website, <https://adamhsparks.github.io/nasapower/>

* Add startup message

### Minor improvements

* Better documentation

--------------------------------------------------------------------------------

# nasapower 0.0.2

### New features

* Added citation file

--------------------------------------------------------------------------------

# nasapower 0.0.1

* Added a `NEWS.md` file to track changes to the package.

* First release, no changes to report yet
