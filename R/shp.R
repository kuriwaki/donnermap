#' Congressional District (116th) Cartogram Shapefile
#'
#' @details These shape files are directly downloaded from Daily Kos
#'  in the link <http://dkel.ec/map>. It additionally adds minimal
#'  formatting of the coordinate system to render properly in R's
#'  `sf`.
#'
#' @format A dataframe with `r nrow(cd_shp)` rows and `r ncol(cd_shp)` variables,
#' including:
#'  \describe{
#'  \item{cd}{District code. The formatting corresponds to the CCES cumulative
#'    coding of \code{cd}: a two-letter abbreviation for the state followed by
#'    a dash, and the district number padded with zeros to the left to be of length
#'    2. At-large districts like Delaware are given a "-01" for the district number.}
#'  \item{geometry}{The simple features (sf) column that wil be used for mapping}
#'  }
#'
#'
#' @author Daniel Donner <http://dkel.ec/map>
#' @examples
#' library(ggplot2)
#' library(ggthemes)
#' library(dplyr)
#'
#' ggplot(cd_shp) + geom_sf() + theme_map()
#'
#' library(dplyr)
#' cd_black <- left_join(cd_shp, race_by_cd, by = "cd") %>%
#'   filter(race == "Black")
#'
#' ggplot(cd_black) +
#'   geom_sf(aes(fill = frac)) +
#'   scale_fill_viridis_b("Percent Black") +
#'   theme_map() +
#'   labs(caption = "Map Source: http://dkel.ec/map")
#'
#'
#'
"cd_shp"


#' State Cartogram Shapefile
#'
#' @author Daniel Donner <http://dkel.ec/map>
#'
#' @examples
#' library(ggplot2)
#' library(ggthemes)
#'
#' ggplot(st_shp) + geom_sf() + theme_map()
#'
"st_shp"

