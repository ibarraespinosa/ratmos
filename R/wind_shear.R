#' Calculates Wind Shear
#'
#' @description \code{\link{wind_shear}} Creates raster from nc path
#'
#' @param u Numeric; u component of wind
#' @param v Numeric; v component of wind
#' @param zlev Numeric; levels of each wind
#' @param zlev_bottom Numeric; bottom nivels to calculate wind shear, from zlev
#' @param zlev_top Numeric; top nivels to calculate wind shear, from zlev
#' @param dataframe Logical; Do you want a data.frame with all values?
#' @export
#' @examples \dontrun{
#' #dont run
#' }
wind_shear <- function(u,
                       v,
                       zlev,
                       zlev_bottom,
                       zlev_top,
                       dataframe = FALSE) {
  # La idea es comparar niveles base con varios niveles verticales
  lbottom <- length(zlev_bottom)
  ltop <- length(top)
  lista <- list()

  dff <- data.frame(u, v, zlev)
  ws  <- matrix(NA, ncol = lbottom, nrow = ltop)
  wsdf  <- matrix(NA, ncol = 6, nrow = lbottom*ltop)
  for(i in 1:lbottom){
    for(j in 1:ltop){
      dff_bottom <- dff[dff$zlev == zlev_bottom[i], ]
      dff_top <- dff[dff$zlev == zlev_top[j], ]
      ws[i,j] <- sqrt((dff_top$u - dff_bottom$u)^2 +
                        (dff_top$v - dff_bottom$v)^2)
    }
  }

  if(dataframe){
    wsdf  <- matrix(NA, ncol = 6, nrow = lbottom*ltop)
    ubottoms <- dff[dff$zlev %in% zlev_bottom, "u"]
    vbottoms <- dff[dff$zlev %in% zlev_bottom, "v"]
    utops <- dff[dff$zlev %in% zlev_top, "u"]
    vtops <- dff[dff$zlev %in% zlev_top, "v"]
    ub <- rep(ubottoms, each = length(utops)) #!
    vb <- rep(vbottoms, each = length(vtops)) #!
    zLevs <- expand.grid(zlev_bottom, zlev_top) #data.frame
    zLevs <- zLevs[rev(order(zLevs$Var1)), ]
    zLevs$Var1 <- ifelse(zLevs$Var1 < zLevs$Var2, NA, zLevs$Var1)
    zLevs <- zLevs[!is.na(zLevs$Var1),]
    df <- data.frame(
      u = ub,
      v = ub,
      zlev_bottom = zLevs$Var1,
      zlev_top = zLevs$Var2,
      ws = as.vector(ws)
    )
    return(df)
  } else{
    return(as.vector(ws))
  }


}
