#' GetPacific Decadal Oscillation (pna) data
#'
#' @description \code{\link{get_pna}} Downloads pna data returning a data.frame
#'
#' @return data.frame
#' @importFrom RCurl url.exists
#' @importFrom utils read.csv
#' @export
#' @note From https://www.ncdc.noaa.gov/teleconnections/pna/:
#'
#' The Pacific-North America (PNA) pattern is one of the most prominent modes
#' of low-frequency variability in the Northern Hemisphere extratropics, appearing
#' in all months except June and July. The PNA pattern reflects a quadripole pattern
#' of 500 millibar height anomalies, with anomalies of similar sign located south
#' of the Aleutian Islands and over the southeastern United States. Anomalies with
#' sign opposite to the Aleutian center are located in the vicinity of Hawaii, and
#' over the intermountain region of North America (central Canada) during the winter
#' and fall.
#'
#' @examples \dontrun{
#' #dont run
#' }
get_pna <- function(){
    url <- "https://www.ncdc.noaa.gov/teleconnections/pna/data.csv"
  if(RCurl::url.exists(url)){
    pna <- utils::read.csv(url, h = T, skip = 1, stringsAsFactors = FALSE)
    names(pna)[2] <- "PNA"
    pna$Date <- as.Date(paste0(pna$Date, "01"), format = "%Y%m%d")
    pna$Year <- as.integer(strftime(pna$Date, "%Y"))
    pna$Month <- as.integer(strftime(pna$Date, "%m"))
    pna <- pna[, c("Date", "Year", "Month", "PNA")]
    return(pna)
  }
}
