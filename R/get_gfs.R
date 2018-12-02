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
#' @param dest directory for storing your GFS grib data.
#' @param id1 Integer; 0, 3 or 6
#' @param id2 Integer; 3 or 4
#'
#' @param verbose Logical; To show operations.
#' @importFrom utils download.file
#' @return raster
#' @export
#' @note
#' trying to get all http://nomads.ncep.noaa.gov/
#' @examples \dontrun{
#' #dont run
#' }
get_gfs <- function(time,
                dest = tempdir(),
                id1 = 3,
                id2 = 0,
                verbose = TRUE){
  if(class(time)== "numeric"){
    if(nchar(time) != 10 ) stop("Please, use a format like '2004120100'")
    dir1 <- substr(time, 0, 6)
    dir2 <- substr(time, 0, 8)
    hour <- substr(time, 9, 10)
  } else if(class(time)[1] == "character"){
    time <- as.POSIXct(time)
    dir1 <- strftime(time, "%Y%m")
    dir2 <- strftime(time, "%Y%m%d")
    hour <- strftime(time, "%H")
  } else if(class(time)[1] == "POSIXct"){
    dir1 <- strftime(time, "%Y%m")
    dir2 <- strftime(time, "%Y%m%d")

  } else {
    stop("time must be numeric, character or POSIXct")
  }
  a <-"ftp://nomads.ncdc.noaa.gov/GFS/analysis_only/"
  f <- paste0("gfsanl_",id1,"_",dir2,"_", hour, "00_00", id2, ".grb2")
  inv <- paste0("gfsanl_",id1,"_",dir2,"_", hour, "00_00", id2, ".inv")
  print(f)

  URL = paste0(a, dir1, "/",dir2, "/", f)
  if(verbose) cat(paste0("FILE: ", f, "\n"))
  INV = paste0(a, dir1, "/",dir2, "/", inv)
  if(verbose) cat(paste0("INV: ", inv, "\n"))
  utils::download.file(url = URL, destfile = paste0(dest, "0.grb2"))
  utils::download.file(url = INV, destfile = paste0(dest, "0.inv"))
}
