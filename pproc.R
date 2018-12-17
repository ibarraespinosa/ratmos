# --------------------------------------------------------------
# Here we pre-process (pproc) the ncdf files
# --------------------------------------------------------------

library(ncdf4)
library(raster)

setwd("Documents/BEPE/work/DJFM_2011-12/obs/")

source("bricknc.R")

# Set the file you want to pre-process
meuarquivo <- "EraInterim/EraInterim_201401_00061218.nc"

# Quick view on the data you want to pre-process.
f <- nc_open(meuarquivo)
print(paste("The file has",f$nvars,"variables"))
print(paste("The file has",names(f$var)))

# Define the variables "vars" and layers "z" you want to use:
vars <- c("q","w",  "d",  "r",  "u",  "v", "z")
z <- 1:6    

# Obtaining the RasterBricks and saving them in .rds files:
for(k in 1:length(z)){
  for(j in 1:length(vars)){
    print(z[k])
    print(vars[j])
    
    u <- bricknc(nc = meuarquivo, 
                 var = vars[j], 
                 z = z[k])

    saveRDS(u, paste0("EraInterim/rds/EraI_",vars[j],"_nivel",z[k],".rds"))
    saveRDS(mean(u),
            paste0("EraInterim/rds/EraI_mean_",vars[j],"_nivel",z[k],".rds"))
  }
}


# Plots ####
# library(cptcity)
# library(mapview)
# library(maps)
# library(mapdata)
u <- bricknc(nc = meuarquivo, 
             var = "r", 
             z = 6)

mapview((u$layer.4),
              legend = T,
              #    col.regions =(cpt("cmocean_deep")),
              map.types = "Esri.WorldImagery",
              alpha = 0.5)
# m1 <- mapview(m, legend = T,col.regions =rev(cpt("cmocean_deep")),
#               map.types = "Esri.WorldImagery") 
# m2 <- mapview(dm, legend = T,  
#               col.regions = rev(cpt("cb_div_RdBu_11",
#                                     n = length(seq(-4.5,4.5,0.05)))),
#               at = seq(-4.5,4.5,0.05))
# 
# sync(m1, m2)