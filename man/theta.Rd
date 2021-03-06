% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/theta.R
\name{theta}
\alias{theta}
\title{Potential Temperature}
\usage{
theta(tk, press, Rd = 287.04, Cp = 1005.7)
}
\arguments{
\item{tk}{Numeric; temperature in kelvin}

\item{press}{Numeric; pressure in hPa or mb}

\item{Rd}{Numeric; Gas constant dry ar = 287.04 J kg^-1 K^-1}

\item{Cp}{Numeric; Specific heat dry air at constant pressure
1005.7 kg^-1 K^-1}
}
\description{
\code{\link{theta}} Calculates potential temperature
}
\examples{
\dontrun{
#dont run
}
}
\references{
Bolton, D. (1980). The computation of equivalent potential
temperature. Monthly weather review, 108(7), 1046-1053.
}
