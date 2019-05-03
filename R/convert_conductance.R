#' Convert conductance units
#'
#' @param .g Conductance in class units. Units must convertible to one of "m/s", "umol/m^2/s/Pa", or "mol/m^2/s"
#'
#' @param P A pressure value of class \code{units} that is convertible to kPa. Default is 101.3246 kPa, Earth's atmospheric pressure at sea level.
#'
#' @param R Ideal gas constant of class \code{units} that is convertible to J/K/kg. Default is 8.31446 J/K/mol.
#'
#' @param Temp A temperature value of class \code{units} that is convertible to K. Default is 25 degreeC (298.15 K).
#'
#' @return @return a [tibble][tibble::tibble-package] in units "m/s", "umol/m^2/s/Pa", and "mol/m^2/s".
#'
#' @examples
#'
#' # library(gunit)
#' library(units)
#'
#' g_sc <- set_units(10, "m/s")
#' convert_conductance(g_sc)
#'
#' g_sc <- set_units(4, "umol/m^2/s/Pa")
#' convert_conductance(g_sc)
#'
#' g_sc <- set_units(0.4, "mol/m^2/s")
#' convert_conductance(g_sc)
#'
#' @export
#'

convert_conductance <- function(
  .g,
  P = set_units(101.3246, kPa),
  R = set_units(8.31446, J/K/mol),
  Temp = set_units(298.15, K)
) {

  # Check and units ----
  stopifnot(inherits(.g, "units"))
  stopifnot(inherits(P, "units"))
  stopifnot(inherits(R, "units"))
  stopifnot(inherits(Temp, "units"))

  P %<>% set_units(kPa)
  R %<>% set_units(J/K/mol)
  Temp %<>% set_units(K)

  # Check lengths ----
  l <- sapply(list(.g, P, R, Temp), length)
  stopifnot(all(l %in% c(1L, max(l))))

  # Extract units ----
  g_unit <- units(.g)

  # Convert units ----
  # Convert from "m/s" to others
  if (length(g_unit$numerator) == 1L &
      stringr::str_detect(g_unit$numerator, "m$") &
      length(g_unit$denominator) == 1L &
      any(g_unit$denominator %in% c("s", "min", "hr"))) {

    .g %<>% set_units("m/s")
    ret <- tibble(
      `m/s` = .g,
      `umol/m^2/s/Pa` = set_units(.g / (R * Temp), umol/m^2/s/Pa),
      `mol/m^2/s` = set_units(.g * P / (R * Temp), mol/m^2/s)
    )

  }

  # Convert from "umol/m^2/s/Pa" to others
  if (length(g_unit$numerator) == 1L &
      stringr::str_detect(g_unit$numerator, "mol$") &
      length(g_unit$denominator) > 1L &
      length(which(stringr::str_detect(g_unit$denominator, "m$"))) == 2L &
      length(which(stringr::str_detect(g_unit$denominator, "Pa$"))) == 1L &
      length(which(g_unit$denominator %in% c("s", "min", "hr"))) == 1L) {

    .g %<>% set_units("umol/m^2/s/Pa")
    ret <- tibble(
      `m/s` = set_units(.g * (R * Temp), m/s),
      `umol/m^2/s/Pa` = .g,
      `mol/m^2/s` = set_units(.g * P, mol/m^2/s)
    )

  }

  # Convert from "mol/m^2/s" to others
  if (length(g_unit$numerator) == 1L &
      stringr::str_detect(g_unit$numerator, "mol$") &
      length(g_unit$denominator) > 1L &
      length(which(stringr::str_detect(g_unit$denominator, "m$"))) == 2L &
      !any(stringr::str_detect(g_unit$denominator, "Pa$")) &
      length(which(g_unit$denominator %in% c("s", "min", "hr"))) == 1L) {

    .g %<>% set_units(mol/m^2/s)
    ret <- tibble(
      `m/s` = set_units(.g * R * Temp / P, m/s),
      `umol/m^2/s/Pa` = set_units(.g / P, umol/m^2/s/Pa),
      `mol/m^2/s` = .g
    )

  }

  if (is.null(ret)) {
    warning("Units of .g did not match acceptable units. Returning NULL.")
    return(NULL)
  }

  ret

}
