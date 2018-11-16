#' Get Outgoing long wave radiation (OLR) equator 160E-160W standarized data
#'
#' @description \code{\link{get_olr}} Downloads OLR data returning a data.frame
#'
#' @return data.frame
#' @importFrom RCurl url.exists
#' @importFrom utils read.csv
#' @export
#' @note From https://www.ncdc.noaa.gov/teleconnections/enso/indicators/olr/
#'
#' Outgoing Longwave Radiation (OLR) data at the top of the atmosphere are observed
#' from the Advanced Very High Resolution Radiometer (AVHRR) instrument aboard the
#' NOAA polar orbiting spacecraft. Data are centered across equatorial areas from
#' 160E to 160W longitude. The raw data are converted into a standardized anomaly
#' index. Negative (Positive) OLR are indicative of enhanced (suppressed) convection
#' and hence more (less) cloud coverage typical of El Nino (La Nina) episodes.
#' More (Less) convective activity in the central and eastern equatorial Pacific
#' implies higher (lower), colder (warmer) cloud tops, which emit much less (more)
#' infrared radiation into space.
#' @examples \dontrun{
#' #dont run
#' }
get_olr <- function(){
    url <- "https://www.ncdc.noaa.gov/teleconnections/enso/indicators/olr/data.csv"
  if(RCurl::url.exists(url)){
    olr <- utils::read.csv(url, h = T, skip = 1, stringsAsFactors = FALSE)
    names(olr)[2] <- "OLR"
    olr$Date <- as.Date(paste0(olr$Date, "01"), format = "%Y%m%d")
    olr$Year <- as.integer(strftime(olr$Date, "%Y"))
    olr$Month <- as.integer(strftime(olr$Date, "%m"))
    olr <- olr[, c("Date", "Year", "Month", "OLR")]
    return(olr)
  }
}
