#' raster to nc 3d
#'
#' @description \code{\link{array3d}} Creates raster from nc path
#'
#' @param u Array.
#' @param z Integer; Level (asusming third dimencion)
#' @param lon Numeric; longitude coordinate.
#' @param lat Numeric; latitude coordinate.
#' @return raster
#' @export
#' @importFrom raster flip raster
#'
array3d <- function(u, lat, lon){
  raster::flip(raster::brick(lapply(
    seq(1, dim(u)[3]),
    function(i) {
      raster::raster(t(u[1:dim(u)[1],
                         dim(u)[2]:1,
                         i]),
                     xmn = min(lon),xmx = max(lon),
                     ymn = min(lat),ymx = max(lat),
                     crs="+init=epsg:4326")
    })), direction = "y")
}
