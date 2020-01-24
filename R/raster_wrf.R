#' Creates raster from nc path
#'
#' @description \code{\link{raster_nc}} Creates raster from nc path
#'
#' @param nc Character; Path to NetCDF.
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
raster_wrf <- function(nc, var, z,
                       array = FALSE, verbose = TRUE){
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
    }
  }
  if(array){
    return(u)
  }

  lat <- ncdf4::ncvar_get(f, "XLAT" )
  lon <- ncdf4::ncvar_get(f, "XLONG" )
  times <- ncdf4::ncvar_get(f, "Times")
  if(verbose){
    cat(paste0("Times from ", times[1], " to ", times[length(times)], "\n"))
    cat(paste0("Lat from ", lat[1], " to ", lat[length(lat)], "\n"))
    cat(paste0("Lon from ", lon[1], " to ", lon[length(lon)], "\n"))
  }

  times <- gsub(pattern = " ", replacement = "_", x = times)
  times <- paste0("T", times)

  if(length(dim(u)) == 4){
    if(missing(z)){
      choice <- utils::menu(1:dim(u)[3], title="Choose Level Z\n")
      z <- (1:dim(u)[3])[choice]
      if(verbose){
        cat(paste0("\nThe level is '", z, "\n"))
      }
    }

    ru1 <- raster::flip(ratmos::array4d(u = u,
                                        z = z,
                                        lat = lat,
                                        lon = lon),
                        direction = "y")
    names(ru1) <- times
  } else if(length(dim(u)) == 3){
    ru1 <- raster::flip(ratmos::array3d(u = u,
                                        lat = lat,
                                        lon = lon),
                        direction = "y")
  } else if(!length(dim(u)) %in% c(3, 4)) {
    stop("Currntly supporting arrays of 3 and 4 dimensions")
  }
  rm(u)
  if(verbose){
    cat(paste0("\nThis ", class(ru1)," is ",
               format(object.size(ru1), units = "Mb"), "\n"))
  }
  return(ru1)
}
