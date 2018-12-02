#' Get Oceanic Nino Index (ONI) data
#'
#' @description \code{\link{get_ao}} Downloads ONI data returning a data.frame
#'
#' @return data.frame
#' @importFrom RCurl url.exists
#' @importFrom utils read.table
#' @export
#' @note From http://origin.cpc.ncep.noaa.gov/products/analysis_monitoring/ensostuff/ONI_v5.php:
#' Includes a threshold of +/- 0.5C for the Oceanic Nino Index (ONI)
#' 3 month running mean of ERSST.v5 SST anomalies in the Nino 3.4 region (5N-5S, 120-170W),
#' @examples \dontrun{
#' #dont run
#' }
get_oni <- function(){
    url <- "http://www.cpc.ncep.noaa.gov/products/analysis_monitoring/ensostuff/detrend.nino34.ascii.txt"
  if(RCurl::url.exists(url)){
    oni = utils::read.table(url, h = T)
    oni$MON
    oni$Date <- as.Date(paste0(oni$YR, ifelse(nchar(oni$MON) < 2,
                                              paste0(0, oni$MON),
                                              oni$MON), "01"),
                        format = "%Y%m%d")
    oni$Year <- as.integer(strftime(oni$Date, "%Y"))
    oni$Month <- as.integer(strftime(oni$Date, "%m"))
    ma <- function(x,n=3){stats::filter(x,rep(1/n,n), sides=2)}
    oni$ONI <- ma(oni$ANOM, 3)
    oni <- oni[, c("Date", "Year", "Month", "ONI")]

    return(oni)
  }
}
