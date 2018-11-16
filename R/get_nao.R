#' Get North Atlantic Oscillation (NAO) data
#'
#' @description \code{\link{get_nao}} Downloads NAO data returning a data.frame
#'
#' @return data.frame
#' @importFrom RCurl url.exists
#' @importFrom utils read.csv
#' @export
#' @note From https://www.ncdc.noaa.gov/teleconnections/enso/indicators/nao/:
#'
#' The North Atlantic Oscillation (NAO) index is based on the surface sea-level
#' pressure difference between the Subtropical (Azores) High and the Subpolar Low.
#' The positive phase of the NAO reflects below-normal heights and pressure across
#' the high latitudes of the North Atlantic and above-normal heights and pressure
#' over the central North Atlantic, the eastern United States and western Europe.
#' The negative phase reflects an opposite pattern of height and pressure anomalies
#' over these regions. Both phases of the NAO are associated with basin-wide changes
#' in the intensity and location of the North Atlantic jet stream and storm track,
#' and in large-scale modulations of the normal patterns of zonal and meridional
#' heat and moisture transport, which in turn results in changes in temperature and
#' precipitation patterns often extending from eastern North America to western and
#' central Europe.
#' @examples {
#' print(head(get_nao()))
#' }
get_nao <- function(){
    url <- "https://www.ncdc.noaa.gov/teleconnections/nao/data.csv"
  if(RCurl::url.exists(url)){
    nao = utils::read.csv(url, h = T, skip = 1, stringsAsFactors = FALSE)
    names(nao)[2] <- "NAO"
    nao$Date <- as.Date(paste0(nao$Date, "01"), format = "%Y%m%d")
    nao$Year <- as.integer(strftime(nao$Date, "%Y"))
    nao$Month <- as.integer(strftime(nao$Date, "%m"))
    nao <- nao[, c("Date", "Year", "Month", "NAO")]
    return(nao)
  }
}
