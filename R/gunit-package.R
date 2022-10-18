#' \code{gunit} package
#'
#' Convert Conductance Units
#'
#' See the README on
#' \href{https://github.com/cdmuir/gunit}{GitHub}
#'
#' @docType package
#' @name gunit
#' @importFrom magrittr %>% %<>%
#' @importFrom methods is
#' @importFrom tibble tibble
#' @importFrom units drop_units set_units
NULL

## quiets concerns of R CMD check re: the .'s that appear in pipelines
if(getRversion() >= "2.15.1")  utils::globalVariables(c("."))

## quiets concerns of R CMD check re: units
utils::globalVariables(c("J", "K", "kPa", "m", "mol", "Pa", "s", "umol"))
