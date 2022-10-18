#' Convert g_c (\eqn{\mu}mol CO2/m^2/s/Pa) to g_w (\eqn{\mu}mol H2O /m^2/s/Pa)
#'
#' @param g_w conductance to water vapor in units
#' (\eqn{\mu}mol H2O / (m^2 s Pa)) of class \code{units}.
#' @param D_c diffusion coefficient for CO2 in air in units of m^2/s of class
#' \code{units}
#' @param D_w diffusion coefficient for H2O in air in units of m^2/s of class
#' \code{units}
#' @param a exponent used for conversion. Use 1 for still air; 0.67 for laminar flow (Jones 2014). Should be unitless.
#' @param unitless Logical. Should scientific units of arguments be checked and set? TRUE is safer, but slower. If FALSE, values provided are assumed to be in correct units.
#'
#' \code{units}
#'
#' @return Value with units \eqn{\mu}mol / (m^2 s Pa) of class \code{units}.
#'
#' @details
#'
#' Diffusive conductance to CO2 is greater than that of H2O because of the
#' higher molecular weight. To convert:
#'
#' \deqn{g_\mathrm{c} = g_\mathrm{w} (D_\mathrm{c} / D_\mathrm{w}) ^ a}{g_c = g_w (D_c / D_w) ^ a}
#' \deqn{g_\mathrm{w} = g_\mathrm{c} (D_\mathrm{w} / D_\mathrm{c}) ^ a}{g_w = g_c (D_w / D_c) ^ a}
#'
#' @note This function will soon be moving to the standalone gunit package.
#'
#' @references
#' Jones H. 2014. Plants and Microclimate (3rd edition). Cambridge University Press.
#'
#' @examples
#' library(units)
#' D_c = set_units(1.29e-05, "m^2/s")
#' D_w = set_units(2.12e-05, "m^2/s")
#' g_c = set_units(3, "umol/m^2/s/Pa")
#' a = 1
#' g_w = gc2gw(g_c, D_c, D_w, a, unitless = FALSE)
#' g_w
#'
#' gw2gc(g_w, D_c, D_w, a, unitless = FALSE)
#' @export
#'

gw2gc = function(
    g_w,
    D_c,
    D_w,
    unitless,
    a
) {
  if (unitless) {
    if (is(g_w, "units")) g_w %<>% drop_units()
    if (is(D_c, "units")) D_c %<>% drop_units()
    if (is(D_w, "units")) D_w %<>% drop_units()
    if (is(a, "units")) a %<>% drop_units()
    g_c = g_w * (D_c / D_w) ^ a
    return(g_c)
  } else {
    g_w %<>% set_units("umol/m^2/s/Pa")
    D_c %<>% set_units("m^2/s")
    D_w %<>% set_units("m^2/s")
    # The exponent should be unitless
    if (is(a, "units")) a %<>% drop_units()
    g_c = g_w * (D_c / D_w) ^ a
    return(g_c)
  }
}

#' Convert g_c (umol CO2/m^2/s/Pa) to g_w (umol H2O /m^2/s/Pa)
#'
#' @rdname gw2gc
#'
#' @param g_c conductance to CO2 in units (\eqn{\mu}mol H2O / (m^2 s Pa)) of
#' class \code{units}.
#' @export
#'

gc2gw = function(
    g_c,
    D_c,
    D_w,
    unitless,
    a
) {
  if (unitless) {
    if (is(g_c, "units")) g_c %<>% drop_units()
    if (is(D_c, "units")) D_c %<>% drop_units()
    if (is(D_w, "units")) D_w %<>% drop_units()
    if (is(a, "units")) a %<>% drop_units()
    g_w = g_c * (D_w / D_c) ^ a
    return(g_w)
  } else {
    g_c %<>% set_units(umol / m^2 / s / Pa)
    D_c %<>% set_units(m^2 / s)
    D_w %<>% set_units(m^2 / s)
    # The exponent should be unitless
    if (is(a, "units")) a %<>% drop_units()
    g_w = g_c * (D_w / D_c) ^ a
    return(g_w)
  }
}
