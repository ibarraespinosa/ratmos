#' Get MERRA2 files
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
#' trying to get all https://goldsmr4.gesdisc.eosdis.nasa.gov/data/MERRA2/M2I1NXASM.5.12.4/2014/10/MERRA2_400.inst1_2d_asm_Nx.20141001.nc4
#' @examples \dontrun{
#' #dont run
#' }
get_merra2 <- function(time,
                dest = tempdir(),
                id1 = 3,
                id2 = 0,
                verbose = TRUE){
  #Experimental
  }
