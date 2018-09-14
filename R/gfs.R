#' Get GFS files
#'
#' @description \code{\link{gfs}} Creates raster from GFS file.
#' The goal is to read and or download file from
#' ftp://nomads.ncdc.noaa.gov/GFS/analysis_only/ from 200403 to
#' present. Inside each directory the files are other firectories
#' for each day, for instance, 20180901.
#'
#'
#' @param time Numeric or POSIXct; numer for Year, Month and Day.
#' For instance, 2004120100 or "2004-12-01 00:00". The
#' only hours available are 00:00, 06:00, 12:00 and 18:00,
#' @param var Character; name of variable. If you dont know,
#' you can choose.
#' @param id1 Integer; 0, 3 or 6
#' @param id2 Integer; 3 or 4
#' @param verbose Logical; To show operations.
#' @return raster
#' @importFrom ncdf4 nc_open ncvar_get
#' @importFrom utils menu object.size
#' @export
#' @note
#' trying to get all http://nomads.ncep.noaa.gov/
#' @examples \dontrun{
#' #dont run
#' }
raster_wrf <- function(time, var, id1 = 3, id2 = 0,
                       dest = file.path(tempdir()),
                       verbose = TRUE){
  if(class(time)== "numeric"){
    if(nchar(time) != 10 ) stop("Please, use a format like '2004120100'")
    dir1 <- subtr(time, 0, 4)
    dir2 <- subtr(time, 0, 8)
    hour <- paste0(subtr(time, 8, 10), "00")
  } else if(class(time)[1] == "character"){
    time <- as.POSIXct(time)
    dir1 <- strftime(time, "%Y%m")
    dir2 <- strftime(time, "%Y%m%d")
    hour <- strftime(time, "%H%M")
  } else if(class(time)[1] == "POSIXct"){
    dir1 <- strftime(time, "%Y%m")
    dir2 <- strftime(time, "%Y%m%d")

  } else {
    stop("time must be numeric, character or POSIXct")
  }
  a <-"ftp://nomads.ncdc.noaa.gov/GFS/analysis_only/"
  f <- paste0("gfsanl_",id1,"_",dir2,"_", hour, "00_00", id2, ".grb2")

  URL = paste0(a, f)
  if(verbose) cat(paste0(URL, "\n"))
  download.file(url = URL,
                destfile = dest)
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

  if(missing(z)){
    choice <- utils::menu(1:dim(u)[3], title="Choose Level Z\n")
    z <- (1:dim(u)[3])[choice]
    if(verbose){
      cat(paste0("\nThe level is '", z, "\n"))
    }
  } else {
    z = z
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
    ru1 <- raster::flip(ratmos::array4d(u = u,
                                        z = z,
                                        lat = lat,
                                        lon = lon),
                        direction = "y")
    names(ru1) <- times
  } else if(length(dim(u)) == 3){
    ru1 <- raster::flip(ratmos::array3d(u = u,
                                        z = z,
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
