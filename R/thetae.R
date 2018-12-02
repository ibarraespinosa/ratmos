#' Equivalent Potential Temperature
#'
#' @description \code{\link{thetae}} Calculates equivalent potential temperature
#'
#' @param theta Numeric; potential temperature in kelvin
#' @param r Numeric; mixing ratio (kg/kg)
#' @param Tlcl Numeric; lifting condensation level Kelvin
#' @export
#' @references  Bolton, D. (1980). The computation of equivalent potential
#' temperature. Monthly weather review, 108(7), 1046-1053.
#' Eq 35
#' @seealso \code{\link{theta}}
#' @examples \dontrun{
#' #dont run
#' }
thetae <- function(theta, r, Tlcl) {  # Eq35
  ratmos::theta*exp((2.675*r)/Tlcl)
}

