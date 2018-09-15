#' Creates raster from nc path
#'
#' @description \code{\link{raster_nc}} Creates raster from nc path
#'
#' @param nc Character; Path to NetCDF.
#' @param xmin Numeric; xmin coordinate.
#' @param xmax Numeric; xmax coordinate.
#' @param ymin Numeric; ymin coordinate.
#' @param ymax Numeric; ymax coordinate.
#' @param dx Numeric; grid spacing x.
#' @param dy Numeric; grid spacing y.
#' @param array Logical; return array or not.
#' @param var Character; name of variable. If you dont know, you can choose.
#' @param z Integer; Level (asusming third dimencion)
#' @param verbose Logical; To show operations.
#' @return raster
#' @importFrom ncdf4 nc_open ncvar_get
#' @importFrom utils menu object.size
#' @export
#' @examples \dontrun{
#' #dont run
#' }
raster_nc <- function(nc,
                      var,
                      xmin,# = -150,
                      xmax,# = 10,
                      ymin,# = -60,
                      ymax,# = 40,
                      dx,# = 215,
                      dy,# = 135,
                      z,# = 6,
                      array = FALSE,
                      verbose = TRUE){
  f <- ncdf4::nc_open(filename = nc)
  if(verbose){
    cat(paste("The file has",f$nvars,"variables:\n"))
    cat(names(f$var))
  }
  if(missing(var)){
    choice <- utils::menu(names(f$var), title="Choose var")
    nvar <- names(f$var)[choice]
    u <- ncdf4::ncvar_get(f, nvar)
    if(verbose){
      cat(paste0("\nThe '", nvar, "' array is ",
                 format(object.size(u), units = "Mb"), "\n"))
    }
  } else {
    u <- ncdf4::ncvar_get(f, var)
    if(verbose){
      cat(paste0("\nThe '", var, "' array is ",
                 format(object.size(u), units = "Mb"), "\n"))
      cat("Dimensions:\n")
      cat(dim(u))
    }
  }
  if(array){
    return(u)
  }
  if(missing(xmin)){
    xmin <- readline(prompt="Enter coordinate xmin (centroid): ")
  } else if(missing(xmax)){
    xmin <- readline(prompt="Enter coordinate xmax (centroid): ")
  } else if(missing(ymin)){
    ymin <- readline(prompt="Enter coordinate ymin (centroid): ")
  } else if(missing(ymax)){
    ymax <- readline(prompt="Enter coordinate ymax (centroid): ")
  } else if(missing(dx)){
    dx <- readline(prompt="Enter number of horizontal points (dx): ")
  } else if(missing(dy)){
    dy <- readline(prompt="Enter number of vertical points (dy): ")
  }
  lon <- seq(xmin, xmax, length.out = dx)
  if(verbose) cat(dx, " longitude points from ", lon[1], " to ",
                  lon[length(lon)], "\n")
  lat <- seq(ymin, ymax, length.out = dy)
  if(verbose) cat(dy, " latitude points from ", lat[1], " to ",
                  lat[length(lat)], "\n")
  if(length(dim(u)) == 4){
    ru1 <- ratmos::array4d(u = u, z = z, lat = lat, lon = lon)
  } else if(length(dim(u)) == 3){
    ru1 <- ratmos::array3d(u = u, z = z, lat = lat, lon = lon)
  } else if(!length(dim(u)) %in% c(3, 4)) {
    stop("Currently supporting arrays of 3 and 4 dimensions")
  }
  if(verbose){
    cat(paste0("\nThis ", class(ru1)," is ",
               format(object.size(ru1), units = "Mb")))
  }
  return(ru1)
}
