#' Sequence of raster
#' @description \code{\link{seqraster}} creates a secuence of absolutes. For
#' instance, if the min of -0.3 and max 1.2, thje resulting sequence it would
#' be from -1.2 to 1.2 by 1/100.
#'
#' @param raster raster
#' @export
#'
seqraster <- function(raster){
  min <- summary(raster)[1]
  max <- summary(raster)[5]
  if(abs(min) > abs(max))
    seq(min, abs(min), ifelse(abs(max) - abs(min) < 1, 1/100, 1))
  else seq(-max, max, ifelse(abs(max) - abs(min) < 1, 1/100, 1))
}
