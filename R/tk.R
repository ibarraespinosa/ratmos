#' Temperature absolute Kelvin
#'
#' @description \code{\link{tk}} Calculates absolute temerature Kelvin
#'
#' @param temperature Numeric temperature in celcius
#' @export
#' @references  Bolton, D. (1980). The computation of equivalent potential
#' temperature. Monthly weather review, 108(7), 1046-1053.
#' Equation 1
#' @examples \dontrun{
#' #dont run
#' }
tk <- function(temperature) {
  temperature + 273.15
  }
