---
title: "ratmos model"
author: "Sergio Ibarra-Espinosa"
date: "7 de Septiembre de 2018"
output: html_document
---

```{r setup, include=FALSE}
knitr::opts_chunk$set(echo = TRUE)
```

# RATMOS

To convert your data from NetCDF atmospheric models to raster,extract data.
Now includes some meteorological function such as [wind_shear](https://ibarraespinosa.github.io/ratmos/wind_shear.html) and [lcl](https://ibarraespinosa.github.io/ratmos/lcl.html)

[![Travis-CI Build Status](https://img.shields.io/badge/lifecycle-experimental-orange.svg?branch=master)](https://travis-ci.org/ibarraespinosa/ratmos)
[![AppVeyor Build Status](https://ci.appveyor.com/api/projects/status/github/ibarraespinosa/ratmos?branch=master&svg=true)](https://ci.appveyor.com/project/ibarraespinosa/ratmos)
[![](http://cranlogs.r-pkg.org/badges/ratmos)](http://cran.rstudio.com/web/packages/ratmos/index.html)
[![Coverage Status](https://img.shields.io/codecov/c/github/ibarraespinosa/ratmos/master.svg)](https://codecov.io/github/ibarraespinosa/ratmos?branch=master)
[![CRAN_Status_Badge](http://www.r-pkg.org/badges/version/ratmos)](http://cran.r-project.org/web/packages/ratmos) 
[![CRAN Downloads](http://cranlogs.r-pkg.org/badges/grand-total/ratmos?color=orange)](http://cran.r-project.org/package=ratmos)
[![Package Status](https://img.shields.io/badge/lifecycle-experimental-organce.svg)](https://www.tidyverse.org/lifecycle/#experimental)


### Installation

**ratmos** can be installed via CRAN or github

```{r eval = F}
devtools::install_github("ibarraespinosa/ratmos")
library(ratmos)
```


## Examples


1. Put the path of your netcdf file.

```{r eval = F, include = T, echo = T}
library(ratmos)
r <- raster_nc("file.nc")
```

If you are using WRF, use this:

```{r eval = F, include = T, echo = T}
r <- raster_wrf("file.nc")
```

2.  Extract your info in a data.frame in long format.

```{r eval = F, include = T, echo = T}
data(cetesb) #SpatialPointsDataFrame
df <- xtractor(x = r,                      # raster
               points = cetesb,            # SpatialPointsDataFrame
               station = cetesb$Station,   # Name of each point
               start = "2016-04-15 00:00") # First hour
```

Please, READ THE DOCUMENTATION: [https://ibarraespinosa.github.io/ratmos/](https://ibarraespinosa.github.io/ratmos/)

Thanks and enjoy ratmos!


##  Issues

If you encounter any issues while using ratmos, please submit your issues to: https://github.com/ibarraespinosa/ratmos/issues/

If you have any suggestions just let me know to sergio.ibarra@usp.br.


### Contributing

Please, read [this](https://github.com/ibarraespinosa/ratmos/blob/master/CONTRIBUTING.md) guide.
Contributions of all sorts are welcome, issues and pull requests are the preferred ways of sharing them.
When contributing pull requests, please follow the [Google's R Style Guide](https://google.github.io/styleguide/Rguide.xml).
This project is released with a [Contributor Code of Conduct](https://github.com/ibarraespinosa/ratmos/blob/master/CODE_OF_CONDUCT.md). By participating in this project you agree to abide by its terms.

