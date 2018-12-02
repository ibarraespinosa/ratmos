#' Lifting Condensation Level
#'
#' @description \code{\link{lcl}} calculates the Lifting Condensation Level in
#' meters.
#'
#' @param p Numeric; presusre in Pascals.
#' @param tk Numeric; temperature in Kelvin.
#' @param rh Numeric; relative humidity with respect to liquid water if
#' tk >= 273.15 K and with respect to ice if tk < 273.15 K.
#' @param rhl Numeric; relative humidity with respect to liquid water
#' @param rhs Numeric; relative humidity with respect to ice
#' @param return_ldl Logical; Do you want Lifting Deposition Level LDL?
#' @param return_min_lcl_ldl Logical; Do you want min of LCL and LDL?
#' @param tktrip Numeric; It is the triple-point temperature. Default
#' 273.16 K
#' @param ptrip Numeric; It is the triple-point vapour pressure. Default
#'  611.65 Pa
#' @param E0v Numeric; It is the  difference in specific internal energy
#' between water vapor and liquid at the triple point. Default =
#' 2.3740E6 J/Kg.
#' @param E0s Numeric; Default = 0.3337E6 J/Kg.
#' @param ggr Numeric; gravity, 9.81 m/s^2
#' @param rgasa Numeric; gas constant for dry air 287.04 J/kg/K
#' @param rgasv Numeric; gas constant for water vapor 461 J/kg/K
#' @param cva Numeric; 719 J/kg/K
#' @param cvv Numeric; 1418 J/kg/K
#' @param cvl Numeric; 4119 J/kg/K
#' @param cvs Numeric; 1861 J/kg/K
#' @param cpa Numeric; cva + rgasa
#' @param cpv Numeric; cvv + rgasv
#' @importFrom LambertW W
#' @importFrom units as_units
#' @export
#' @references  Romps, D. M. (2017). Exact Expression for the
#' Lifting Condensation Level. Journal of the Atmospheric Sciences,
#' 74(12), 3891-3900.
#' @examples {
#' a <- abs(lcl(1e5,300,rhl=.5,return_ldl=FALSE))
#' b <- 1433.844139279*units::as_units("m")
#' c <- 1
#' as.numeric(a / b) - c < 1e-10
#' if(
#' abs(as.numeric(lcl(1e5,300,rhs=.5,return_ldl=FALSE))/( 923.2222457185)-1) < 1e-10 &
#' abs(as.numeric(lcl(1e5,200,rhl=.5,return_ldl=FALSE))/( 542.8017712435)-1) < 1e-10 &
#' abs(as.numeric(lcl(1e5,200,rhs=.5,return_ldl=FALSE))/( 1061.585301941)-1) < 1e-10 &
#' abs(as.numeric(lcl(1e5,300,rhl=.5,return_ldl=TRUE ))/( 1639.249726127)-1) < 1e-10 &
#' abs(as.numeric(lcl(1e5,300,rhs=.5,return_ldl=TRUE ))/( 1217.336637217)-1) < 1e-10 &
#' abs(as.numeric(lcl(1e5,200,rhl=.5,return_ldl=TRUE ))/(-8.609834216556)-1) < 1e-10 &
#' abs(as.numeric(lcl(1e5,200,rhs=.5,return_ldl=TRUE ))/( 508.6366558898)-1) < 1e-10 ) {
#' cat('Success\n')
#' } else {
#'   cat('Failure\n')
#' }
#'}
lcl <- function(p,
                tk,
                rh = NULL,
                rhl = NULL,
                rhs = NULL,
                return_ldl = FALSE,
                return_min_lcl_ldl = FALSE,
                tktrip = 273.16,     # K
                ptrip = 611.65,     # Pa
                E0v   = 2.3740e6,   # J/kg
                E0s   = 0.3337e6,   # J/kg
                ggr   = 9.81,       # m/s^2
                rgasa = 287.04,     # J/kg/K
                rgasv = 461,        # J/kg/K
                cva   = 719,        # J/kg/K
                cvv   = 1418,       # J/kg/K
                cvl   = 4119,       # J/kg/K
                cvs   = 1861,       # J/kg/K
                cpa   = cva + rgasa,
                cpv   = cvv + rgasv) {

  # Parameters

  # tkhe saturation vapor pressure over liquid water
  pvstarl <- function(tk) {
    return( ptrip * (tk/tktrip)^((cpv-cvl)/rgasv) *
              exp( (E0v - (cvv-cvl)*tktrip) / rgasv * (1/tktrip - 1/tk) ) )
  }

  # tkhe saturation vapor pressure over solid ice
  pvstars <- function(tk) {
    return( ptrip * (tk/tktrip)^((cpv-cvs)/rgasv) *
              exp( (E0v + E0s - (cvv-cvs)*tktrip) / rgasv * (1/tktrip - 1/tk) ) )
  }

  # Calculate pv from rh, rhl, or rhs
  rh_counter <- 0
  if (!is.null(rh )) { rh_counter <- rh_counter + 1 }
  if (!is.null(rhl)) { rh_counter <- rh_counter + 1 }
  if (!is.null(rhs)) { rh_counter <- rh_counter + 1 }
  if (rh_counter != 1) {
    stop('Error in lcl: Exactly one of rh, rhl, and rhs must be specified')
  }
  if (!is.null(rh)) {
    # tkhe variable rh is assumed to be
    # with respect to liquid if tk > tktrip and
    # with respect to solid if tk < tktrip
    if (tk > tktrip) {
      pv <- rh * pvstarl(tk)
    } else {
      pv <- rh * pvstars(tk)
    }
    rhl <- pv / pvstarl(tk)
    rhs <- pv / pvstars(tk)
  } else if (!is.null(rhl)) {
    pv <- rhl * pvstarl(tk)
    rhs <- pv / pvstars(tk)
    if (tk > tktrip) {
      rh <- rhl
    } else {
      rh <- rhs
    }
  } else if (!is.null(rhs)) {
    pv <- rhs * pvstars(tk)
    rhl <- pv / pvstarl(tk)
    if (tk > tktrip) {
      rh <- rhl
    } else {
      rh <- rhs
    }
  }
  if (pv > p) {
    return(NA)
  }

  # Calculate lcl and ldl
  qv <- rgasa*pv / (rgasv*p + (rgasa-rgasv)*pv)
  rgasm <- (1-qv)*rgasa + qv*rgasv
  cpm <- (1-qv)*cpa + qv*cpv
  if (rh==0) {
    return(cpm*tk/ggr)
  }
  al  <- -(cpv-cvl)/rgasv + cpm/rgasm
  bl  <- -(E0v-(cvv-cvl)*tktrip)/(rgasv*tk)
  cl  <- pv/pvstarl(tk)*exp(-(E0v-(cvv-cvl)*tktrip)/(rgasv*tk))
  as  <- -(cpv-cvs)/rgasv + cpm/rgasm
  bs  <- -(E0v+E0s-(cvv-cvs)*tktrip)/(rgasv*tk)
  cs  <- pv/pvstars(tk)*exp(-(E0v+E0s-(cvv-cvs)*tktrip)/(rgasv*tk))
  lcl <- cpm*tk/ggr*( 1 - bl/(al*LambertW::W(bl/al*cl^(1/al),-1)) )
  ldl <- cpm*tk/ggr*( 1 - bs/(as*LambertW::W(bs/as*cs^(1/as),-1)) )

  # Return either lcl or ldl
lcl <- lcl*units::as_units("m")
lsl <- ldl*units::as_units("m")
  if (return_ldl & return_min_lcl_ldl) {
    stop('return_ldl and return_min_lcl_ldl cannot both be true')
  } else if (return_ldl) {
    return(ldl)
  } else if (return_min_lcl_ldl) {
    return(min(lcl,ldl))
  } else {
    return(lcl)
  }

}

