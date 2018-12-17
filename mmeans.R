# --------------------------------------------------------------
# Calculates means for the daily, montlhy and/or seasonal term
# --------------------------------------------------------------

library(ncdf4)
library(raster)

setwd("Documents/BEPE/work/DJFM_2011-12/obs/")

# Set the file you want to obtain the means
meuarquivo <- "EraInterim/EraInterim_201401_00061218.nc"
f <- nc_open(meuarquivo)
print(f)

fhour = 0   # first hour to be considered
lhour = 23  # last hour to be considered
tstep = 6
ndays = 31


# Escolher a média
mtype <- 0 # 1, 2 ou 3

media <- function(nc,
              var,
              mtype,
              ndays,
              fhour = 0,
              lhour = 23,
              tstep = 6,
              array = FALSE, 
              z = 6,
              xmin = -150, 
              xmax = 10, 
              ymin = -60, 
              ymax = 40, 
              dx = 215, 
              dy = 135){
  
  # Bricknc  #### 
  # Abre o arquivo NetCDF desejado e verifica variaveis que tem:  
  f <- nc_open(filename = nc)
  cat(paste("The file has",f$nvars,"variables:"))
  cat(names(f$var))
  
  # Abaixo a variável de interesse é obtida e a ela atribuída o nome "u"
  # Caso o usuário não definir a variavel (var = _ ) ao chamar o bricknc
  # o if abaixo vai perguntar qual variável usar através da função "menu"
  # do pacote "utils". "missing" --> Does a Formal Argument have a Value?
  if(missing(var)){
    choice <- utils::menu(names(f$var), title="Choose var")
    nvar <- names(f$var)[choice]
    u <- ncdf4::ncvar_get(f, nvar)
    cat(paste0("\nThe '", nvar, "' array is ",
               format(object.size(u), units = "Mb"), "\n"))
  } else {
    u <- ncdf4::ncvar_get(f, var)
    cat(paste0("\nThe '", var, "' array is ",
               format(object.size(u), units = "Mb"), "\n"))
  }
  
  # Se já é array, ou seja, se "array = TRUE" retorna u diretamente. 
  # Se não, pula para o prox passo.
  if(array){
    return(u)
  }
  
  # ATÉ AQUI OBTEMOS UM ARRAY A PARTIR DO NETCDF. 
  # AGORA VAMOS OBTER UMA LISTA.
  
  # Atribui a cada ponto de grade as devidas latitudes e longitudes. 
  a <- function(x) ifelse(x < 0, - 1, 1)
  lon <- seq(xmin, xmax, by = length((xmin - a(xmin)):xmax)/dx)
  lat <- seq(ymin, ymax, by = length((ymin - a(ymin)):ymax)/dy)
  
  # Cria uma lista para cada tempo i, ou seja, uma lista com 124 elementos
  # "dim(u)[4]" indica o tempo
  # "dim(u)[1]" indica o núm de pontos em x (longitude)
  # "dim(u)[2]" indica o num de pontos em y (latitude)
  lista <- list()
  for (i in seq(1, dim(u)[4])) {
    lista[[i]] <- raster(t(u[1:dim(u)[1],
                             dim(u)[2]:1,
                             z,
                             i]),
                         xmn = min(lon),
                         xmx = max(lon),
                         ymn = min(lat),
                         ymx = max(lat),
                         crs="+init=epsg:4326")
  }
  
  # Aqui usa o "flip", invertendo assim a ordem das linhas ou colunas,
  # dependendo se "direction = 'y'" ou "direction='x'", respectivamente.
  # ru1 será o valor retornado com a função "bricknc" e terá classe 
  # "RasterBrick" e "raster".
  ru1 <- flip(brick(lista), direction = "y")
  cat(paste0("\nThis brick is ", format(object.size(ru1), units = "Mb")))
  
  # Media ####
  timeseq <- seq(fhour, lhour, tstep)
  lgttimeseq <- length(timeseq)
  ttimes <- lgttimeseq*ndays # deve ser igual ao time quando "print(nc)"
  cat(paste0("Total number of times = ", ttimes, "  -->  ", lgttimeseq, " times per day"))
  
  if (mtype = 0) {
    return(ru1) 
  } else if (mtype = 1) { # Calcula a média mensal e retorna "ru1" e a "media calculada"
    
    
    output <- list(ru1, meanmean)
    return(output)
    
  } else if (mtype = 2) {
    # Calcula a média sazonal
    
    output <- list(ru1, meanmean)
    return(output)
  } else {
    # Calcula a média horária
    
    output <- list(ru1, meanmean)
    return(output)
  }
    
  
}