#' Creates raster from nc path to RegCM
#'
#' @description \code{\link{raster_nc}} Creates raster from nc path
#'
#' @param nc Character; Path to NetCDF.
#' @param array Logical; return array or not.
#' @param var Character; name of variable. If you dont know, you can choose.
#' @param verbose Logical; To show operations.
#' @return raster
#' @importFrom ncdf4 nc_open ncvar_get
#' @importFrom utils menu object.size
#' @importFrom raster rotate raster
#' @importFrom stats filter
#' @export
#' @examples \dontrun{
#' #dont run
#' }
raster_regcm <- function(nc,
                         var,
                         array = FALSE,
                         verbose = TRUE){
  f <- ncdf4::nc_open(filename = nc)
  if(verbose){
    cat(paste("The file has",f$nvars,"variables:\n"))
    cat(names(f$var))
  }
  if(missing(var)){
    choice <- utils::menu(names(f$var), title="Choose var")
    var <- names(f$var)[choice]
  }
  if(array){
    u <- ncdf4::ncvar_get(f, var)
  } else {
    u <- raster::rotate(raster::brick(nc), varname = var)
  }
  if(verbose){
    cat(paste0("Object: '", var, "\nClass: ",class(u), "\nSize: " ,
               format(object.size(u), units = "Mb"), "\nDimensions: ", dim(u)))
  }
  return(u)
}
