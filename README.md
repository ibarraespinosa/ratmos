---
title: "ratmos model"
author: "Sergio Ibarra-Espinosa"
date: "7 de Septiembre de 2018"
output: html_document
---



# RATMOS


[![Travis-CI Build Status](https://img.shields.io/badge/lifecycle-experimental-orange.svg?branch=master)](https://travis-ci.org/ibarraespinosa/ratmos)
[![AppVeyor Build Status](https://ci.appveyor.com/api/projects/status/github/ibarraespinosa/ratmos?branch=master&svg=true)](https://ci.appveyor.com/project/ibarraespinosa/ratmos)
[![](http://cranlogs.r-pkg.org/badges/ratmos)](http://cran.rstudio.com/web/packages/ratmos/index.html)
[![Coverage Status](https://img.shields.io/codecov/c/github/ibarraespinosa/ratmos/master.svg)](https://codecov.io/github/ibarraespinosa/ratmos?branch=master)
[![CRAN_Status_Badge](http://www.r-pkg.org/badges/version/ratmos)](http://cran.r-project.org/web/packages/ratmos) 
[![CRAN Downloads](http://cranlogs.r-pkg.org/badges/grand-total/ratmos?color=orange)](http://cran.r-project.org/package=ratmos)
[![Package Status](https://img.shields.io/badge/lifecycle-experimental-organce.svg)](https://www.tidyverse.org/lifecycle/#experimental)
[![Github Stars](https://img.shields.io/github/stars/ibarraespinosa/ratmos.svg?style=social&label=Github)](https://github.com/ibarraespinosa/ratmos)


Package to process meteorological data. 
I included converting your data from NetCDF atmospheric models to raster with special functions to WRF and RegCM.
Now included some meteorological function such as [wind_shear](https://ibarraespinosa.github.io/ratmos/wind_shear.html) and [lcl](https://ibarraespinosa.github.io/ratmos/lcl.html)


### Installation

**ratmos** can be installed via github

```r
devtools::install_github("ibarraespinosa/ratmos")
library(ratmos)
```


## Examples


- Put the path of your netcdf file.

```r
library(ratmos)
r <- raster_nc("file.nc")
r <- raster_wrf("file.nc")
r <- raster_regcm("file.nc") #experimental
```

- Extract your info in a data.frame in long format.

```r
library(ratmos)
data(cetesb) #SpatialPointsDataFrame
df <- xtractor(x = r,                      # raster
               points = cetesb,            # SpatialPointsDataFrame
               station = cetesb$Station,   # Name of each point
               start = "2016-04-15 00:00") # First hour
```

- Download climate index

```r
library(ratmos)
b <- get_all_index(olr = FALSE)
library(ggplot2)
library(cptcity)
ggplot(b, aes(x = Date, y = index, colour = index)) + geom_line()+
facet_wrap(~name, ncol = 2, scales = "free") + theme_bw() +
scale_colour_gradientn(colours = rev(cpt(find_cpt("cb_div_RdB")[2])), limit = c(-4.6, 4.6))
```


![](https://i.imgur.com/f28PW2d.png)

Please, READ THE DOCUMENTATION: [https://ibarraespinosa.github.io/ratmos/](https://ibarraespinosa.github.io/ratmos/)

Thanks and enjoy ratmos!


##  Issues

If you encounter any issues while using ratmos, please submit your issues to: https://github.com/ibarraespinosa/ratmos/issues/
If you have any suggestions just let me know to sergio.ibarra@usp.br.


### Contributing

Contributions of all sorts are welcome, issues and pull requests are the preferred ways of sharing them.
When contributing pull requests, please follow the [Google's R Style Guide](https://google.github.io/styleguide/Rguide.xml).
This project is released with a [Contributor Code of Conduct](https://github.com/ibarraespinosa/ratmos/blob/master/CODE_OF_CONDUCT.md). By participating in this project you agree to abide by its terms.

