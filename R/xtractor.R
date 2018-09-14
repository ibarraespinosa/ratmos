#' extractor from atmospheric models
#'
#' @description Return data.framee or list of raster and df from points.
#' @param atmos Character; path to output of model (wrfout)
#' @param vars Character; Variable with has 3 or 4 dimensions.
#' @param level Integer; Which level
#' @param points data.frame, matrix, SpatialPointsDataFrame or sf 'POINTS',
#' with coordinates East-weast (lat), north-south (long) and 'Station'.
#' @param stations Character; names of stations for each point.
#' @param crs_points Integer, crs points.
#' @param model Character; Currently, only "WRF"
#' @param return_list Logical; If TRUE, return a list with raster and data.frames
#' if FALSE, only data.frame.
#' @return Return data.framee or list of raster and df
#' @importFrom eixport wrf_get
#' @importFrom ncdf4 nc_open ncvar_get
#' @importFrom raster extract brick raster
#' @importFrom sf st_as_sf st_transform as_Spatial
#' @importFrom tidyr gather
#' @importFrom methods as
#' @note Based on NCL scrip xtractor from DCA/IAG/USP
#' @export
#' @examples \dontrun{
#' data(cetesb)
#' #use your wrfout
#' #wrf <- "~/Documentos/wrfo/wrfoA.nc"
#' t2 = c("T2", "o3", "no")
#' df <- xtractor(atmos = wrf, vars = t2, points = cetesb[1:3, ],
#' stations = cetesb$Station[1:3])
#' r <- xtractor(atmos = wrf, vars = t2, points = cetesb[1, ], return_list = T)
#' }
xtractor <- function(x,
                     points, name_points = "CC",
                     crs_points = 4326,
                     model = "WRF",
                     return_list = FALSE) {
  # stations
  if(class(points)[1] == "matrix" | class(points)[1] == "data.frame"){
    points <- as.data.frame(points)
    names(points) <- c("x", "y", "Station")
    sp::coordinates(points) <- data.frame(x = points$x, y = points$y)
    sp::proj4string(points) <- "+init=epsg:4326"
  } else if(class(points)[1] == "SpatialPointsDataFrame"){
    names(points) <- c("Station")
  }

df <- raster::extract(x = x, y = points, df = TRUE)
  df <- list()
dft <- do.call("cbind",lapply(1:length(df), function(i){
  df[[i]]$ID <- NULL
  names(df[[i]]) <- times
  tidyr::gather(df[[i]])
}))
return(dft)
}
