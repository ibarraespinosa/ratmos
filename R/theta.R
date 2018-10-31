#' Potential Temperature
#'
#' @description \code{\link{theta}} Calculates potential temperature
#'
#' @param tk Numeric; temperature in kelvin
#' @param press Numeric; pressure in hPa or mb
#' @param Rd Numeric; Gas constant dry ar = 287.04 J kg^-1 K^-1
#' @param Cp Numeric; Specific heat dry air at constant pressure
#' 1005.7 kg^-1 K^-1
#' @export
#' @references  Bolton, D. (1980). The computation of equivalent potential
#' temperature. Monthly weather review, 108(7), 1046-1053.
#' @examples \dontrun{
#' #dont run
#' }
theta <- function(tk, press, Rd = 287.04, Cp = 1005.7) { #approx Eq 7
  tk * (1000/press) ^(Rd/Cp)
}

