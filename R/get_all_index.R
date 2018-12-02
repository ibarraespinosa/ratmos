#' Get all index in long format
#'
#' @description \code{\link{get_all_index}} Downloads all index returning a data.frame
#'
#' @param nao Logica; inlude nao?
#' @param olr Logica; inlude olr?
#' @param oni Logica; inlude oni?
#' @param pdo Logica; inlude pdo?
#' @param pna Logica; inlude pna?
#' @param soi Logica; inlude soi?
#' @param sstoi Logica; inlude sstoi?
#' @param aao Logica; inlude aao?
#' @return data.frame
#' @export
#' @note From https://www.ncdc.noaa.gov/teleconnections/enso/indicators/
#' @examples \dontrun{
#' #do not run
#' a <- get_all_index()
#' head(a)
#' tail(a)
#' b <- get_all_index(olr = FALSE)
#' library(ggplot2)
#' library(cptcity)
#' ggplot(b, aes(x = Date, y = index, colour = index)) + geom_line()+
#' facet_wrap(~name, ncol = 3, scales = "free") + theme_bw() +
#' scale_colour_gradientn(colours = rev(cpt(find_cpt("cb_div_RdB")[2])), limit = c(-4.6, 4.6))
#' head(b)
#' tail(b)
#' }
get_all_index <- function(nao = TRUE,
                          olr = TRUE,
                          oni = TRUE,
                          pdo = TRUE,
                          pna = TRUE,
                          soi = TRUE,
                          sstoi= TRUE,
                          aao = TRUE){

  ao  <- get_ao()
  names(ao)[4] <- "index"
  ao$name <- "AO"
  if(nao){
    dfnao <- get_nao()
    names(dfnao)[4] <- "index"
    dfnao$name <- "NAO"
  }
  if(olr){
    dfolr <- get_olr()
    names(dfolr)[4] <- "index"
    dfolr$name <- "OLR"
  }
  if(oni){
    dfoni <- get_oni()
    names(dfoni)[4] <- "index"
    dfoni$name <- "ONI"
    }
  if(pdo){
    dfpdo <- get_pdo()
    names(dfpdo)[4] <- "index"
    dfpdo$name <- "PDO"
  }
  if(pna){
    dfpna <- get_pna()
    names(dfpna)[4] <- "index"
    dfpna$name <- "PNA"
  }
  if(soi){
    dfsoi <- get_soi()
    names(dfsoi)[4] <- "index"
    dfsoi$name <- "SOI"
  }
  if(sstoi){
    dfsstoi <- get_sstoi(long = TRUE)
    names(dfsstoi)[c(4,5)] <- c("index", "name")
  }
  if(aao){
    dfaao <- get_aao()
    names(dfaao)[4] <- "index"
    dfaao$name <- "AAO"
  }
  df <- rbind(ao,
              if(nao) dfnao,
              if(olr) dfolr,
              if(oni) dfoni,
              if(pdo) dfpdo,
              if(pna) dfpna,
              if(soi) dfsoi,
              if(sstoi) dfsstoi,
              if(aao) dfaao)
  return(df)
}
