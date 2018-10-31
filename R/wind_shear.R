#' Calculates Wind Shear
#'
#' @description \code{\link{wind_shear}} Creates raster from nc path
#'
#' @param u Numeric; u component of wind
#' @param v Numeric; v component of wind
#' @param zlev Numeric; levels of each wind
#' @param zlev_bottom Numeric; bottom nivels to calculate wind shear, from zlev
#' @param zlev_top Numeric; top nivels to calculate wind shear, from zlev
#' @param list Logical; Do you want a list of data.frames with all values?
#' @export
#' @examples \dontrun{
#' #dont run
#' }
wind_shear <- function(u,
                        v,
                        zlev,
                        zlev_bottom,
                        zlev_top,
                        list = FALSE) {
  # La idea es comparar niveles base con varios niveles verticales
  lbottom <- length(zlev_bottom)
  print(lbottom)
  ltop <- length(zlev_top)
  print(ltop)

  dff <- data.frame(u, v, zlev)
  ws  <- as.data.frame(matrix(NA, ncol = lbottom, nrow = ltop))
  row.names(ws) <- zlev_top
  names(ws) <- zlev_bottom
  ubottom <- utop <- vbottom <- vtop <- ws
  print(dim(ws))
  for(i in 1:lbottom){
    for(j in 1:ltop){
      dff_bottom <- dff[dff$zlev == zlev_bottom[i], ]
      print(dff_bottom)
      dff_top <- dff[dff$zlev == zlev_top[j], ]
      print(dff_top)

      ws[j,i] <- sqrt((dff_top$u - dff_bottom$u)^2 +
                        (dff_top$v - dff_bottom$v)^2)
      ubottom[j, i] <- c(dff_bottom$u)
      vbottom[j, i] <- c(dff_bottom$v)
      utop[j, i] <- c(dff_top$u)
      vtop[j, i] <- c(dff_top$v)
    }
  }

  if(list){
    df <- data.frame(zbottom = rep(zlev_bottom, each = length(zlev_top)))
    df$ztop <- rep(zlev_top, length(zlev_bottom))
    df$ubottom <- unlist(ubottom)
    df$vbottom <- unlist(vbottom)
    df$utop <- unlist(utop)
    df$vtop <- unlist(vtop)
    df$ws <- unlist(ws)
    return(list(ws, df))
  } else{
    return(as.vector(ws))
  }


}
