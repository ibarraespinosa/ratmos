#' Get Southern Oscillation Index (SOI)
#'
#' @description \code{\link{get_soi}} Downloads SOI index returning a data.frame
#'
#' @return data.frame
#' @importFrom RCurl url.exists
#' @importFrom utils read.csv
#' @export
#' @note From https://www.ncdc.noaa.gov/teleconnections/enso/indicators/soi/
#'
#' The Southern Oscillation Index (SOI) is a standardized index based on
#' the observed sea level pressure differences between Tahiti and Darwin,
#' Australia. The SOI is one measure of the large-scale fluctuations in air
#' pressure occurring between the western and eastern tropical Pacific (i.e.,
#' the state of the Southern Oscillation) during El Nino and La Nina episodes.
#' In general, smoothed time series of the SOI correspond very well with changes
#' in ocean temperatures across the eastern tropical Pacific. The negative phase
#' of the SOI represents below-normal air pressure at Tahiti and above-normal air
#' pressure at Darwin. Prolonged periods of negative (positive) SOI values coincide
#' with abnormally warm (cold) ocean waters across the eastern tropical Pacific
#' typical of El Nino (La Nina) episodes.
#' @examples \dontrun{
#' #dont run
#' }
get_soi <- function(){
    url <- "https://www.ncdc.noaa.gov/teleconnections/enso/indicators/soi/data.csv"
  if(RCurl::url.exists(url)){
    soi <- utils::read.csv(url, h = T, skip = 1, stringsAsFactors = FALSE)
    names(soi)[2] <- "soi"
    soi$Date <- as.Date(paste0(soi$Date, "01"), format = "%Y%m%d")
    soi$Year <- as.integer(strftime(soi$Date, "%Y"))
    soi$Month <- as.integer(strftime(soi$Date, "%m"))
    soi <- soi[, c("Date", "Year", "Month", "soi")]
    return(soi)
  }
}
