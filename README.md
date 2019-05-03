
<!-- README.md is generated from README.Rmd. Please edit that file -->

# gunit

<!-- badges: start -->

[![CRAN
status](https://www.r-pkg.org/badges/version/gunit)](https://cran.r-project.org/package=gunit)
[![Build
Status](https://travis-ci.com/cdmuir/gunit.svg?token=yprDUtRtPBa2Ma9G4sFP&branch=master)](https://travis-ci.com/cdmuir/gunit)
[![Lifecycle:
maturing](https://img.shields.io/badge/lifecycle-maturing-blue.svg)](https://www.tidyverse.org/lifecycle/#maturing)
<!-- badges: end -->

In plant physiology, conductance to heat, carbon dioxide, and water
vapour are expressed in different units for different purposes. For heat
exchange, units of m/s are most often used, whereas for gas exchange
units of either mol/m^2/s (the default output from LICOR devices) or
umol/m^2/s/Pa are used. I found it difficult to keep all the conversions
straight, so I made a small package to help ensure proper conversion.

## Installation

You can install the current version of gunit from
[GitHub](https://github.com/cdmuir/gunit) with:

``` r
remotes::install.packages("cdmuir/gunit")
```

Or the released version of gunit from [CRAN](https://CRAN.R-project.org)
with:

``` r
install.packages("gunit")
```

## Example

This is a basic example which shows you how to solve convert conductance
units:

``` r
library(gunit)
library(units)
#> udunits system database from /Library/Frameworks/R.framework/Versions/3.6/Resources/library/units/share/udunits

g_sw <- set_units(0.4, mol/m^2/s)
convert_conductance(g_sw)
#> # A tibble: 1 x 3
#>         `m/s` `umol/m^2/s/Pa` `mol/m^2/s`
#>         [m/s] [umol/m^2/Pa/s] [mol/m^2/s]
#> 1 0.009786197        3.947709         0.4

# Change Temperature and Pressure
g_sw <- set_units(0.4, mol/m^2/s)
convert_conductance(g_sw, 
                    P = set_units(80, kPa), 
                    Temp = set_units(293, K))
#> # A tibble: 1 x 3
#>        `m/s` `umol/m^2/s/Pa` `mol/m^2/s`
#>        [m/s] [umol/m^2/Pa/s] [mol/m^2/s]
#> 1 0.01218068               5         0.4

# Calculations can also be vectorized

g_sw <- set_units(seq(0.1, 0.4, 0.1), mol/m^2/s)
convert_conductance(g_sw)
#> # A tibble: 4 x 3
#>         `m/s` `umol/m^2/s/Pa` `mol/m^2/s`
#>         [m/s] [umol/m^2/Pa/s] [mol/m^2/s]
#> 1 0.002446549       0.9869272         0.1
#> 2 0.004893099       1.9738543         0.2
#> 3 0.007339648       2.9607815         0.3
#> 4 0.009786197       3.9477087         0.4
```

## Contributors

  - [Chris Muir](https://github.com/cdmuir)

## Comments and contributions

I welcome comments, criticisms, and especially contributions\! GitHub
issues are the preferred way to report bugs, ask questions, or request
new features. You can submit issues here:

<https://github.com/cdmuir/gunit/issues>

## Meta

  - Please [report any issues or
    bugs](https://github.com/cdmuir/gunit/issues).
  - License: MIT
  - Get citation information for `gunit` in R doing `citation(package =
    'gunit')`
  - Please note that the ‘gunit’ project is released with a [Contributor
    Code of Conduct](CODE_OF_CONDUCT.md). By contributing to this
    project, you agree to abide by its terms.
