#' Get Antartic Oscillation (AAO) data
#'
#' @description \code{\link{get_aao}} Downloads AAO data returning a data.frame
#'
#' @return data.frame
#' @importFrom RCurl url.exists
#' @importFrom utils read.table
#' @export
#' @note From http://www.cpc.noaa.gov/products/precip/CWlink/daily_ao_index/aao/aao.shtml:
#' The daily AAO index is constructed by projecting the daily (00Z)
#'  700mb height anomalies poleward of 20°S onto the loading pattern of the AAO.
#'  Please note that year-round monthly mean anomaly data
#'  have been used to obtain the loading pattern of the AAO.
#'  Since the AAO has the largest variability during the cold season,
#'  the loading pattern primarily captures characteristics of the cold season
#'  AAO pattern.
#'
#' @examples {
#' print(head(get_aao()))
#' }
get_aao <- function(){
  url <- "http://www.cpc.noaa.gov/products/precip/CWlink/daily_ao_index/aao/monthly.aao.index.b79.current.ascii"
  if(RCurl::url.exists(url)){
    aao <- utils::read.table(url, header = F, stringsAsFactors = FALSE)
    names(aao) <- c("Year","Month", "AAO")
    aao$Month <- ifelse(aao$Month <=9, paste0("0", aao$Month), aao$Month)
    aao$Date <- as.Date(paste0(aao$Year, aao$Month, "01"), format = "%Y%m%d")
    aao$Year <- as.integer(strftime(aao$Date, "%Y"))
    aao$Month <- as.integer(strftime(aao$Date, "%m"))
    aao <- aao[, c("Date", "Year", "Month", "AAO")]
    return(aao)
  }
}
