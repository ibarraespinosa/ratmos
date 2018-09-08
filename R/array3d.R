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
array3d <- function(u, z, lat, lon){
  ru1 <- raster::flip(raster::raster(t(u[1:dim(u)[1],
                                         dim(u)[2]:1,
                                         z]),
                                     xmn = min(lon),
                                     xmx = max(lon),
                                     ymn = min(lat),
                                     ymx = max(lat),
                                     crs="+init=epsg:4326"),
                      direction = "y")
  return(ru1)
}
