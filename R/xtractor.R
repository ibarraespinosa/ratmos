#' extractor from atmospheric models
#'
#' @description Return data.framee
#' @param x raster (or brick)
#' @param points data.frame, matrix, SpatialPointsDataFrame.
#' @param stations Character; names of stations for each point.
#' @param start Character or POSIXct; first GMT hour of data.
#' @param by Numeric, number of seconds in time sequence.
#' @return Return long data.frame (for ggplot2)
#' @importFrom sp coordinates proj4string
#' @importFrom raster extract
#' @importFrom tidyr gather
#' @note Based on NCL scrip xtractor from DCA/IAG/USP
#' @export
#' @examples \dontrun{
#' #do not run
#' }
xtractor <- function(x, points, stations, start = "2016-04-15 00:00", by = 3600) {
  # stations
  if(class(points)[1] == "matrix" | class(points)[1] == "data.frame"){
    points <- as.data.frame(points)
    # if(!names(points) %in% c("x", "y")){
    #   stop("Names of df must be x and y")
    # }
    sp::coordinates(points) <- data.frame(x = points$x, y = points$y)
    sp::proj4string(points) <- "+init=epsg:4326"
  }
  dft <- lapply(1:nrow(points), function(i){
    tidyr::gather(raster::extract(x = x, y = points[i, ] , df = TRUE))
  })
  for(i in 1:length(dft)){
    dft[[i]]$Station <- stations[i]
  }
  dft <- do.call("rbind", dft)
  dft <- dft[dft$key != "ID", ]
  if(!missing(start)){
  start <- as.POSIXct(start, tz = "GMT")
  dft$times <- seq.POSIXt(start, length.out = length(names(x)), by = by)
  }
  return(dft)
}
