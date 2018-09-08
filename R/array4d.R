#' raster to nc 4d
#' @description \code{\link{array4d}} Creates raster from nc path
#'
#' @param u Array.
#' @param z Integer; Level (asusming third dimencion)
#' @param lon Numeric; longitude coordinate.
#' @param lat Numeric; latitude coordinate.
#' @export
#' @importFrom raster flip raster
#'
array4d <- function(u, z, lat, lon) {
  raster::flip(raster::brick(lapply(seq(1, dim(u)[4]), function(i) {
    raster::raster(t(u[1:dim(u)[1],
                       dim(u)[2]:1,
                       z,
                       i]),
                   xmn = min(lon),xmx = max(lon),
                   ymn = min(lat),ymx = max(lat),
                   crs="+init=epsg:4326")
  })), direction = "y")
}
