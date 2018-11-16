#' Get Arctic Oscillation (AO) data
#'
#' @description \code{\link{get_ao}} Downloads AO data returning a data.frame
#'
#' @return data.frame
#' @importFrom RCurl url.exists
#' @importFrom utils read.csv
#' @export
#' @note From https://www.ncdc.noaa.gov/teleconnections/ao/:
#' AO index is obtained by projecting the AO loading pattern to the daily anomaly
#' 1000 millibar height field over 20N-90N latitude. The AO loading pattern has
#' been chosen as the first mode of EOF analysis using monthly mean 1000 millibar
#' height anomaly data from 1979 to 2000 over 20N-90N.
#' @examples {
#' print(head(get_ao()))
#' }
get_ao <- function(){
  url <- "https://www.ncdc.noaa.gov/teleconnections/ao/data.csv"
  if(RCurl::url.exists(url)){
    ao <- utils::read.csv(url, skip = 1, stringsAsFactors = FALSE)
    names(ao)[2] <- "AO"
    ao$Date <- as.Date(paste0(ao$Date, "01"), format = "%Y%m%d")
    ao$Year <- as.integer(strftime(ao$Date, "%Y"))
    ao$Month <- as.integer(strftime(ao$Date, "%m"))
    ao <- ao[, c("Date", "Year", "Month", "AO")]
    return(ao)
  }
}
