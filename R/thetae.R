#' Equivalent Potential Temperature
#'
#' @description \code{\link{thetae}} Calculates potential temperature
#' equivalent
#'
#' @param theta Numeric; temperature in kelvin
#' @param r Numeric; mixing ratio (kg/kg)
#' @param Tlcl Numeric; lifting condensation level Kelvin
#' @export
#' @references  Bolton, D. (1980). The computation of equivalent potential
#' temperature. Monthly weather review, 108(7), 1046-1053.
#' Eq 35
#' @examples \dontrun{
#' #dont run
#' }
theta_e <- function(theta, r, Tlcl) {  # Eq35
  theta*exp((2.675*r)/Tlcl)
}

