#' Calculates Wind Shear
#'
#' @description \code{\link{wind_shear}} Creates raster from nc path
#'
#' @param u Numeric;
#' @param v Numeric;
#' @param zlev Numeric;
#' @param at_zlev Numeric;
#' @param zdiff Numeric;
#' @param ascending Logical;
#' @param dataframe Logical;
#' @export
#' @examples \dontrun{
#' #dont run
#' }
wind_shear <- function(u,
                       v,
                       zlev,
                       at_zlev,
                       zdiff,
                       ascending = TRUE,
                       dataframe = FALSE) {
  if(!missing(at_zlev)){
    dff <- data.frame(u, v, zlev)
    dff <- dff[dff$zlev %in% at_zlev, ]
    u <- dff$u
    v <- dff$v
  }
  if(ascending){
    utop <- c(u[2:length(u)], NA)
    ubottom <- u
    vtop <- c(v[2:length(v)], NA)
    vbottom <- v
  } else {
    ubottom   <- c(u[2:length(u)], NA)
    utop <- u
    vbottom   <- c(v[2:length(v)], NA)
    vtop <- v
  }
  if(missing(zdiff)) {
    wsh <- sqrt((utop - ubottom)^2 + (vtop - vbottom)^2)
  } else {
    wsh <- sqrt((utop - ubottom)^2 + (vtop - vbottom)^2)/zdiff
  }
  if(dataframe){
    df <- as.data.frame(cbind(utop, ubottom, vtop, vbottom, wsh))
    return(df)
  } else{
    return(wsh)
  }
}
