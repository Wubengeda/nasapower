
#' @title Create an APSIM metFile File from NASA - POWER Data
#'
#' @description Get NASA-POWER values for a single point or region and create
#' an APSIM \code{\link[APSIM]{metFile}} object suitable for use in APSIM for
#' crop modelling.
#'
#' @export
#' @param lonlat A numeric vector of geographic coordinates for a cell or region
#'  entered as x, y coordinates.  See argument details for more.
#' @param dates A character vector of start and end dates in that order,\cr
#'  *e.g.*, `dates = c("1983-01-01", "2017-12-31")`.  See argument details for
#'  more.
#'
#' @details This function is essentially a wrapper for \code{\link{get_power}}
#' and \code{\link[APSIM]{prepareMet}} that simplifies the querying of the
#' POWER API and returns an \code{\link[APSIM]{metFile}} class object.
#'
#' The weather values from POWER for temperature are 2 metre max and min
#' temperatures, T2M_MAX and T2M_MIN; radation, ALLSKY_SFC_SW_DWN; and rain,
#' PRECTOT from the POWER AG community on a daily time-step.
#'
#' Further details for each of the arguments are provided in their
#' respective sections following below.
#'
#' @section Argument details for `lonlat`:
#' \describe{
#'  \item{For a single point}{To get a specific cell, 1/2 x 1/2 degree, supply a
#'  length-2 numeric vector giving the decimal degree longitude and latitude in
#'  that order for data to download,\cr
#'  *e.g.*, `lonlat = c(151.81, -27.48)`.}
#'
#'  \item{For regional coverage}{To get a region, supply a length-4 numeric
#'  vector as lower left (lat, lon) and upper right (lat, lon) coordinates,
#'  *e.g.*, `lonlat = c(ymin, xmin, ymax, xmax)` in that order for a given
#'  region, *e.g.*, a bounding box for the southwestern corner of Australia:
#'  `lonlat = c(112.5, -55.5, 115.5, -50.5)`. *Max bounding box is 10 x 10
#'  degrees* of 1/2 x 1/2 degree data, *i.e.*, 100 points maximum in total.}
#' }
#'
#' @section Argument details for `dates`: If `dates` is unspecified, defaults to
#'  a start date of 1983-01-01 (the earliest available data) and an end date of
#'  current date according to the system.
#'
#'  If one date only is provided, it will be treated as both the start date and
#'  the end date and only a single day's values will be returned.
#'
#' @examples
#' # Create a .met object for Kingsthorpe, Qld from 1985-01-01 to 1985-06-30.
#'
#' \dontrun{
#' Kingsthorpe <- create_met(lonlat = c(151.81, -27.48),
#'                           dates = c("1985-01-01", "1985-12-31")
#' )
#' }
#'
#' @author Adam H. Sparks, \email{adamhsparks@@gmail.com}
#'
create_met <- function(lonlat = NULL,
                       dates = NULL) {

  if (!is.numeric(lonlat) && toupper(lonlat) == "GLOBAL") {
    stop(
      call. = FALSE,
      "The `lonlat` must be numeric values. Global coverage is not",
      "available for `create_met()`"
    )
  }

  power_data <- as.data.frame(
    get_power(
      pars = c("T2M_MAX",
               "T2M_MIN",
               "ALLSKY_SFC_SW_DWN",
               "PRECTOT"),
      dates = dates,
      lonlat = lonlat,
      temporal_average = "DAILY",
      community = "AG"
    )
  )

  power_data <-
    dplyr::select(power_data,
                  "YEAR",
                  "DOY",
                  "T2M_MAX",
                  "T2M_MIN",
                  "PRECTOT",
                  "ALLSKY_SFC_SW_DWN")

  met_names <- c("year",
                 "day",
                 "maxt",
                 "mint",
                 "radn",
                 "rain")

  met_units <-
    c("()",
      "()",
      "(oC)",
      "(oC)",
      "(MJ/m^2/day)",
      "(mm)")

  out <- APSIM::prepareMet(
    power_data,
    lat = power_data[2, 1],
    lon = power_data[1, 1],
    newNames = met_names,
    units = met_units
  )

  return(out)
}
