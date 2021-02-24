
<!-- README.md is generated from README.Rmd. Please edit that file -->

# donnermap

<!-- badges: start -->
<!-- badges: end -->

The goal of donnermap is to quickly plot data visualizations involving
states and congressional districts. Districts are drawn roughly
proportional to the number of seats they have in the US Congress. This
is beneficial for some visualizations where geographic maps will obscure
densely populated areas such as New York City, Los Angeles, Miami, and
Houston.

The package is named after Daniel Donner, who made this map. A
discussion of the map can be found
[here](https://medium.com/nightingale/hexes-tiles-and-districts-757a0506329f).

The development version can be installed from this repository with:

``` r
# install.packages("devtools")
devtools::install_github("kuriwaki/donner-map")
```

## Example

``` r
library(donnermap)

# For graphing
library(ggplot2)
library(sf)
library(ggthemes)
library(dplyr)
library(scales)
```

``` r
ggplot(cd_shp) + geom_sf() + theme_map()
```

<img src="man/figures/README-base_map-1.png" width="100%" />

Joining a shape file to a dataframe (but not the reverse) will append
the data. Since the race data here is in long form, the joined dataframe
will be in long-form as well.

``` r
cd_race <- left_join(cd_shp, race_by_cd, by = "cd")

# plot
ggplot(cd_race) +
  geom_sf(data = st_shp, fill = "transparent", size = 0.5) +
  geom_sf(aes(fill = frac), size = 0.1, color = "white") +
  scale_fill_viridis_b(
    "Percent of Voting Age", 
    na.value = "white", 
    breaks = seq(0, 1, 0.1), 
    labels = percent_format(accuracy = 1)) +
  facet_wrap(~ race) +
  theme_map() +
  labs(caption = "Map Source: http://dkel.ec/map. Race Data: ACS 2014-2018, obtained through tidycensus.") +
  theme(legend.position = c(0.75, 0.1))
```

<img src="man/figures/README-race_map-1.png" width="100%" />
