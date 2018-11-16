#' Get Sea Surface Temperature Oceanic Index Data (sstoi)
#'
#' @description \code{\link{get_sstoi}} Downloads ONI data returning a data.frame
#'
#' @param long Logical; Return data.frame in long format?
#' @param only_anomaly Logical; only anomalies??
#' @return data.frame
#' @importFrom RCurl url.exists
#' @importFrom utils read.table
#' @export
#' @note From https://www.ncdc.noaa.gov/teleconnections/enso/indicators/sst/
#' @examples {
#' print(head(get_sstoi(long = TRUE)))
#' }
get_sstoi <- function(long = FALSE, only_anomaly = TRUE){
    url <- "http://www.cpc.ncep.noaa.gov/data/indices/sstoi.indices"
  if(RCurl::url.exists(url)){
    sstoi <- utils::read.table(url, h = T)
    sstoi$Date <- as.Date(paste0(sstoi$YR, ifelse(nchar(sstoi$MON) < 2,
                                              paste0(0, sstoi$MON),
                                              sstoi$MON), "01"),
                        format = "%Y%m%d")
    sstoi$Year <- as.integer(strftime(sstoi$Date, "%Y"))
    sstoi$Month <- as.integer(strftime(sstoi$Date, "%m"))
    names(sstoi)[3:10] <- c("NINO1.2", "ANOM1.2", "NINO3", "ANOM3", "NINO4", "ANOM4", "NINO3.4", "ANOM3.4")
    sstoi <- sstoi[, c("Date", "Year", "Month", names(sstoi)[3:10])]
    if(!long & !only_anomaly){
      return(sstoi)
    } else if(!long & only_anomaly){
      sstoi <- sstoi[, c("Date", "Year", "Month", "ANOM1.2", "ANOM3", "ANOM4", "ANOM3.4")]
      return(sstoi)
    } else if(long & !only_anomaly){
      ind <- sstoi[, names(sstoi)[4:ncol(sstoi)] ]
      sstoi <- sstoi[, c("Date", "Year", "Month")]
      value <- unlist(ind)
      index <- rep(names(ind), each = nrow(ind))
      sstoi <- data.frame(Date = rep(sstoi$Date, each = ncol(ind)),
                          Year = rep(sstoi$Year, each = ncol(ind)),
                          Month = rep(sstoi$Month, each = ncol(ind)))
      sstoi$value
      sstoi$index
      return(sstoi)
    } else if(long & only_anomaly){
      ind <- sstoi[, c( "ANOM1.2", "ANOM3",  "ANOM4", "ANOM3.4")]
      sstoi <- sstoi[, c("Date", "Year", "Month")]
      value <- unlist(ind)
      name_index <- rep(names(ind), each = nrow(ind))
      sstoi <- data.frame(Date = rep(sstoi$Date, each = ncol(ind)),
                          Year = rep(sstoi$Year, each = ncol(ind)),
                          Month = rep(sstoi$Month, each = ncol(ind)))
      sstoi$value <- value
      sstoi$name_index <- name_index
      return(sstoi)

    }
  }
}
