
cd_popup <- paste0("<strong>", cd_shp$cd, "</strong>")

# Leaflet CRS object for WGS84 projection
epsg4326 <- leafletCRS(
  crsClass = 'L.Proj.CRS',
  code = 'EPSG:4326',
  proj4def = '+init=epsg:4326 +proj=longlat +datum=WGS84 +no_defs +ellps=WGS84 +towgs84=0,0,0',
  resolutions = 2^(16:10))

leaflet(cd_shp, options = leafletOptions(crs = epsg4326)) %>%
  addPolygons(
    stroke = TRUE, # remove polygon borders
    fillColor = "lightgray",
    fillOpacity = 0.8, smoothFactor = 0.5, # make it nicer
    popup = cd_popup)
