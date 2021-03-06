% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/get_gfs.R
\name{get_gfs}
\alias{get_gfs}
\title{Get GFS files}
\usage{
get_gfs(time, dest = tempdir(), id1 = 3, id2 = 0, verbose = TRUE)
}
\arguments{
\item{time}{Numeric or POSIXct; numer for Year, Month and Day.
For instance, 2004120100 or "2004-12-01 00:00". The
only hours available are 00:00, 06:00, 12:00 and 18:00,}

\item{dest}{directory for storing your GFS grib data.}

\item{id1}{Integer; 0, 3 or 6}

\item{id2}{Integer; 3 or 4}

\item{verbose}{Logical; To show operations.}
}
\value{
raster
}
\description{
\code{\link{gfs}} Creates raster from GFS file.
The goal is to read and or download file from
ftp://nomads.ncdc.noaa.gov/GFS/analysis_only/ from 200403 to
present. Inside each directory the files are other firectories
for each day, for instance, 20180901.
}
\note{
trying to get all http://nomads.ncep.noaa.gov/
}
\examples{
\dontrun{
#dont run
}
}
