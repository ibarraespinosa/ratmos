#' Get Pacific Decadal Oscillation (PDO) data
#'
#' @description \code{\link{get_pdo}} Downloads PDO data returning a data.frame
#'
#' @return data.frame
#' @importFrom RCurl url.exists
#' @importFrom utils read.csv
#' @export
#' @note From https://www.ncdc.noaa.gov/teleconnections/pdo/:
#'
#' The Pacific Decadal Oscillation (PDO) is often described as a long-lived
#' El Nino-like pattern of Pacific climate variability (Zhang et al. 1997).
#' As seen with the better-known El Nino/Southern Oscillation (ENSO), extremes
#' in the PDO pattern are marked by widespread variations in the Pacific Basin
#' and the North American climate. In parallel with the ENSO phenomenon, the
#' extreme phases of the PDO have been classified as being either warm or cool,
#' as defined by ocean temperature anomalies in the northeast and tropical Pacific
#' Ocean. When SSTs are anomalously cool in the interior North Pacific and warm
#' along the Pacific Coast, and when sea level pressures are below average over
#' the North Pacific, the PDO has a positive value. W
#' @references
#' Zhang, Y., Wallace, J. M., & Battisti, D. S. (1997). ENSO-like interdecadal
#' variability: 1900–93. Journal of climate, 10(5), 1004-1020.
#'
#' @examples \dontrun{
#' #dont run
#' }
get_pdo <- function(){
    url <- "https://www.ncdc.noaa.gov/teleconnections/pdo/data.csv"
  if(RCurl::url.exists(url)){
    pdo <- utils::read.csv(url, h = T, skip = 1, stringsAsFactors = FALSE)
    names(pdo)[2] <- "PDO"
    pdo$Date <- as.Date(paste0(pdo$Date, "01"), format = "%Y%m%d")
    pdo$Year <- as.integer(strftime(pdo$Date, "%Y"))
    pdo$Month <- as.integer(strftime(pdo$Date, "%m"))
    pdo <- pdo[, c("Date", "Year", "Month", "PDO")]
    return(pdo)
  }
}
