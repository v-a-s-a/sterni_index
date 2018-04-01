library(leaflet)
library(RCurl)
library(htmlwidgets)

csv_handle <- getURL('https://docs.google.com/spreadsheets/d/e/2PACX-1vQ5PIoUB3bujfpUwi2phvXx_ZecNTpRfTVGc9tq2cgsMQ5uttRxZs86p_cZ_RF9L9FrT8rTxLUNlNwF/pub?gid=939729708&single=true&output=csv')
sterni <- read.csv(textConnection(csv_handle))

pal <- colorNumeric(
  palette = 'YlOrRd',
  domain = c(0.50, 8))


map <- leaflet(data=sterni) %>% 
  setView(lat = 52.506955, lng = 13.407455, zoom = 12) %>%
  addProviderTiles('Stamen.TonerLite') %>%
  addCircleMarkers(lng = ~lon, lat = ~lat, fillColor = ~pal(cost), radius = 5, fillOpacity = 1, stroke=F) %>%
  addLegend('bottomright', pal = pal, values = ~cost,
            title = "cost",
            opacity = 1)

map

saveWidget(map, file='/Users/vasya/Projects/sterni_index/test_index/index.html', selfcontained=FALSE)