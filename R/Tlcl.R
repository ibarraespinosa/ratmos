#' Temperature at the Lifting Condensation Level
#'
#' @description \code{\link{tk}} Calculates absolute temperature
#'
#' @param tk Numeric; temperature in kelvin
#' @param rh Numeric; relative humidity in percentage
#' @export
#' @references  Bolton, D. (1980). The computation of equivalent potential
#' temperature. Monthly weather review, 108(7), 1046-1053.
#' Equation 22
#' @examples \dontrun{
#' #dont run
#' }
Tncl <- function(tk, rh){
  1/( ( 1/(tk - 55) ) - ( (log(rh/100))/2840 ) ) + 55
}

