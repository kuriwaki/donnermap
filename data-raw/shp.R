library(ccesMRPprep)
library(tidyverse)
library(glue)
library(patchwork)
library(usethis)

# election data
cd_info_2018


# raw shp
st_shp <- read_sf("data-raw/HexSTv20/")
cd_shp <- read_sf("data-raw/HexCDv21/")

st_crs(st_shp) <- 3857
st_crs(cd_shp) <- 3857

# map_crs <- function(crs, data = cd_shp) {
#   st_crs(data) <- crs
#   ggplot(data) + geom_sf() +
#     theme_bw() +
#     labs(title = glue("CRS: {crs}")) +
#     theme(plot.title = element_text(hjust = 0.5, face = "bold"))
# }
#
# map_crs(4326) + map_crs(3857) + map_crs(4328) + map_crs(3857) +
#   plot_layout(nrow = 2, widths = c(0.5, 0.5))

cd_shp <- cd_shp %>%
  mutate(cd = glue("{STATEAB}-{str_pad(CDLABEL, width = 2, pad = '0')}"),
         cd = str_replace(cd, "-[A-Z][A-Z]$", "-01")) %>%
  relocate(cd)



usethis::use_data(st_shp, overwrite = TRUE)
usethis::use_data(cd_shp, overwrite = TRUE)
