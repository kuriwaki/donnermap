#' Congressional District Cartogram Shapefile
#'
#' @author Daniel Donner <http://dkel.ec/map>
#' @examples
#' library(ggplot2)
#' library(ggthemes)
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

